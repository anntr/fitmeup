class Drop < ActiveRecord::Migration
  def change
    drop_table :recipes
  end
end
