fileStr= File.read("pasta.json")
products_informations = JSON.parse(fileStr)
products = []
products_informations.each do |product_info|
  product = { uid: product_info["ndbno"], name: product_info["name"] }
  measures = {}
  cal_measures = []
  carbs_measures = []
  lipids_measures = []
  proteins_measures = []
  product_info["nutrients"].each do |nutrient_info|
    if nutrient_info["nutrient_id"] == "208" #kalorie
      product[:calories] = nutrient_info["value"]
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        cal_measures << measure
      end
    elsif nutrient_info["nutrient_id"] == "204"  #lipidy
      product[:lipids] = nutrient_info["value"]
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        lipids_measures << measure
      end
    elsif nutrient_info["nutrient_id"] == "205" #wegle
      product[:carbs] = nutrient_info["value"]
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        carbs_measures << measure
      end
    elsif nutrient_info["nutrient_id"] == "203" #proteiny
      product[:proteins] = nutrient_info["value"]
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        proteins_measures << measure
      end
    end
    measures[:calories] = cal_measures
    measures[:carbs] = carbs_measures
    measures[:lipids] = lipids_measures
    measures[:proteins] = proteins_measures

  end
  product[:units] = measures
  products << product
end


products.each_with_index do |product_params, inx|
  product = Product.create(product_params.except(:units))
  product.save!
  puts product.inspect

  first_measure = Measure.create(:unit => "gram", :eqv => 1, :calories => product.calories/100,
  :carbs => product.carbs/100, :lipids => product.lipids/100, :proteins => product.proteins/100,
  :product_id => product.id)
  first_measure.save

  units_info = product_params[:units]
  units = []
  units_info[:calories].each do |unit|
    u = unit[:label]
    units << u
  end

  units.each_with_index do |unit, index|
    measure = {:unit => unit, :eqv => units_info[:calories][index][:eqv]}
    measure[:calories] = units_info[:calories][index][:value]
    measure[:carbs] = units_info[:carbs][index][:value]
    measure[:lipids] = units_info[:lipids][index][:value]
    measure[:proteins] = units_info[:proteins][index][:value]
    measure[:product_id] = product.id
    mes = Measure.create(measure)
    mes.save!
  end



end




