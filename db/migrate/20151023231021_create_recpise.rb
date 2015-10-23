class CreateRecpise < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.string :category, array: true, default: []
      t.integer :calories
    end
  end
end
