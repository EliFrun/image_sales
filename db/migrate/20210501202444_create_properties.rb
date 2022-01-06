class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.integer :property_id
      t.string :name
      t.integer :image

      t.timestamps
    end
  end
end
