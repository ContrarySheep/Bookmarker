class BookmarksController < ApplicationController
  
  before_filter :authorize
  
  def index
    @bookmarks = @collection.bookmarks
  end
  
  def new
    @bookmark = Bookmark.new
  end
  
  def import
  end
  
  def process_import
    @collection = Collection.find(params[:collection_id])
    existing_plist = params[:plist]
    extracted_bookmarks = extract_bookmarks(existing_plist)
    for bookmark in extracted_bookmarks do
      bookmark = Bookmark.create(:name => bookmark[1][0], :link => bookmark[0][0], :collection_id => params[:collection_id])
      bookmark.save
    end
    respond_to do |format|
        format.html { redirect_to authentic_bookmarks_path, notice: 'Bookmarks Updated.' }
    end
  end
  
  def show
    @bookmark = Bookmark.find_by_id(params[:id])
    if !@bookmark.nil? && @bookmark.collection_id == @collection.id
      render 'edit'
    else
      redirect_to root_path
    end
  end
  
  def create
    @bookmark = Bookmark.new(params[:bookmark])
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to new_authentic_bookmark_path, notice: 'Bookmark added.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def update
    @bookmark = Bookmark.find(params[:id])
    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to authentic_bookmarks_path, notice: 'Bookmark updated.' }
      else
        format.html { render action: "show" }
      end
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to authentic_bookmarks_path
  end
  
  def bookmarks
    @bookmarks = @collection.bookmarks
  end
  
  protected
  
  def authorize
    @collection = Collection.find_by_name(@authentic_collection)
    if !@collection
      redirect_to root_url
    end
  end
  
  def extract_bookmarks(plist)
    plist = plist.sub("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r\n<plist version=\"1.0\">\r\n<array>\r\n  ","")
    plist = plist.sub("\r\n</array>\r\n</plist>\r\n","")
    plist = plist.gsub("\r\n  \t","")
    plist = plist.gsub("\r\n","")
    plistArray = plist.split("<\/dict>  <dict>")
    bookmarkArray = Array.new
    for raw_bookmark in plistArray do
      bookmarkArray << process_raw_bookmark(raw_bookmark)
    end
    return bookmarkArray
  end
  
  def process_raw_bookmark(raw_bookmark)
    processed_bookmark = Array.new
    processed_bookmark << raw_bookmark.scan(/<string>(.*?)<\/string>/)
    return processed_bookmark[0]
  end
  
end
