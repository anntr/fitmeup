class ChangeProducts < ActiveRecord::Migration
  def change
    add_column :products, :uid, :string
  end
end
