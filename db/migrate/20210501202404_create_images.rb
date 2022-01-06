class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :image_id
      t.string :name
      t.integer :owner
      t.decimal :price
      t.string :properties

      t.timestamps
    end
  end
end
