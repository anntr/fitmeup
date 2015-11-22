class AddTranslation < ActiveRecord::Migration
  def change
    add_column :products, :name_t, :string
    add_column :measures, :unit_t, :string
  end
end
