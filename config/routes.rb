Bookmarker::Application.routes.draw do
    
  root :to => 'application#index'
  
  match 'establish' => 'application#establish_collection', :as => 'establish_collection', :via => :post
  
  match ':id' => 'bookmarks#edit', :via => :get, :constraints => {:id => /\d/}
  
  scope ":collection_name", :as => 'authentic' do
    match 'bookmarks.plist' => 'bookmarks#bookmarks', :as => 'plist', :via => :get, :format => :plist
    match 'import' => 'bookmarks#import', :as => 'bookmark_import', :via => :get
    match 'import' => 'bookmarks#process_import', :as => 'bookmark_process_import', :via => :post
    resources :bookmarks, :path => '/', :except => 'edit'
  end
  
end
