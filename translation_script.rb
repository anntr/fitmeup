require 'csv'


csv_text = File.read('ostateczny.csv')#, :encoding => Encoding::Windows_1250)
=begin
if !csv_text.valid_encoding?
  csv_text = csv_text.encode(Encoding::Windows_1250, :invalid=>:replace, :replace=>"?")
end
=end
csv = CSV.parse(csv_text, :col_sep => ",", :quote_char => '"')
product = nil
csv.each_with_index do |row, index|
  puts row
  uid = row[0]
  name = row[1]
  translation = row[2]
  unit = row[3]
  translation_unit = row[5]

  updating_product = Product.where(:uid =>  uid).first

  if updating_product.name_t == nil
    if product != updating_product
      updating_product.update_attribute(:name_t, translation)
      puts updating_product.inspect
      product = updating_product
    end
  end
=begin

  if unit.start_with?('"')
    unit.slice!(0)
    unit.slice!(unit.length - 1)
    unit.gsub!('""', '"')
  end
=end

  measure = Measure.where(:product => updating_product, :unit => unit ).first
  puts measure.inspect
  measure.update_attribute(:unit_t, translation_unit)
  puts "after: #{measure.inspect}"

end