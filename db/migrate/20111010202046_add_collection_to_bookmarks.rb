class AddCollectionToBookmarks < ActiveRecord::Migration
  def up
      add_column :bookmarks, :collection_id, :integer
    end

    def down
      remove_column :bookmarks, :collection_id
    end
end
