fileStr= File.read("fooddetails.json")
products_informations = JSON.parse(fileStr)
products_informations.each do |product_info|
  product = { uid: product_info["ndbno"], name: product_info["name"] }
  measures = []
  product_info["nutrients"].each do |nutrient_info|

    if nutrient_info["nutrient_id"] == "208" #kalorie
      cal_measures = []
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
      lipids_measures = []
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        lipids_measures << measure
      end
    elsif nutrient_info["nutrient_id"] == "205" #wegle
      product[:carbs] = nutrient_info["value"]
      carbs_measures = []
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        carbs_measures << measure
      end
    elsif nutrient_info["nutrient_id"] == "203" #proteiny
      product[:proteins] = nutrient_info["value"]
      proteins_measures = []
      nutrient_info["measures"].each do |measure_info|
        measure = {}
        measure[:label] = measure_info["label"]
        measure[:value] = measure_info["value"]
        measure[:eqv] = measure_info["eqv"]
        proteins_measures << measure
      end
    end

  end


end


