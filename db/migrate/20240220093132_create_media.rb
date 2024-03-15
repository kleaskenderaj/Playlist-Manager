class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :title
      t.text :description
      t.string :content_url

      t.timestamps
    end
  end
end
