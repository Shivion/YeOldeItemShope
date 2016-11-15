class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :stock
      t.float :price
      t.float :percentage_off

      t.timestamps
    end
  end
end
