class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authentic_collection
  before_filter :instantiate_controller_and_action_names
  
  def index
    @collection = Collection.new
    render :template => '/index', :layout => false
  end
  
  def establish_collection
    processed_name = process_name(params[:collection][:name])
    @collection = Collection.find_or_create_by_name(processed_name)
    redirect_to authentic_bookmarks_path(processed_name)
  end
  
  protected
  
  def authentic_collection
    if params[:collection_name]
      @authentic_collection = params[:collection_name]
    end
  end
  
  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end
  
  def process_name(user_input)
    user_input.gsub(/[^0-9A-Za-z]/, '')
  end
  
end
