class Measure < ActiveRecord::Base
  belongs_to :product

  def self.get_by_unit_and_product(unit, product_id)
    where(:unit => unit, :product_id => product_id).first
  end

end