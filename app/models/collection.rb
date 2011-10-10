class Collection < ActiveRecord::Base
  
  validates_presence_of :name
  
  has_many :bookmarks, :order => 'name ASC'
  
end
