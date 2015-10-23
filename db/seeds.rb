# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


(1..200).each do
  Recipe.create(:name => Faker::Lorem.sentence, :category => [(rand(5)+1).to_s], :calories => 100+rand(600),
                :instructions => Faker::Lorem.paragraphs.join )
end


