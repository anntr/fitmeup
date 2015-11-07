class CreateMeasures < ActiveRecord::Migration
  def change
    create_table :measures do |t|
      t.string :unit
      t.integer :calories
      t.float :carbs
      t.float :lipids
      t.float :proteins
      t.float :eqv
      t.integer :product_id
    end
  end
end
