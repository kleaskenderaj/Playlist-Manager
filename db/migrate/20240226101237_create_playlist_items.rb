class CreatePlaylistItems < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_items do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :medium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
