class AddUserIdToPlaylists < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :user_id, :int
  end
end
