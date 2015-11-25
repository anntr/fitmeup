class SaveMenus < ActiveRecord::Migration
  def change
    add_column :menus, :saved, :boolean
  end
end
