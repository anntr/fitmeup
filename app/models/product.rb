require 'csv'

class Product < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_many :measures
  validates :name, uniqueness:  true

  def self.to_csv(ids = [])
    if ids.blank?
      products = Product.all
    else
      products = Product.where(:uid => ids)
    end

    CSV.open('nowe_produkty.csv','wb', col_sep: ";") do |csv|
      products.each do |product|
        product.measures.each do |measure|
        csv << [product.uid,product.name,product.name_t || "X" ,measure.unit,measure.id,measure.unit_t || "Y"]
        end
      end

    end
  end
end
