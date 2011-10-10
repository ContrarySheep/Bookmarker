class Bookmark < ActiveRecord::Base
  
  validates_presence_of :link, :collection_id
  
  belongs_to :collection
   
end
