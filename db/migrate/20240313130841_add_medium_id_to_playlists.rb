class AddMediumIdToPlaylists < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :medium_id, :integer
  end
end
