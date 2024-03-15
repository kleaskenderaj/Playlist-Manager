class RemoveMediumIdFromPlaylists < ActiveRecord::Migration[6.1]
  def change
    remove_column :playlists, :medium_id, :integer
  end
end
