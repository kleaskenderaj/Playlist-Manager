class CreateMediumDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :medium_devices do |t|
      t.references :medium, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
  end
end
