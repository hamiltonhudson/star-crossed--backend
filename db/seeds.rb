# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DatabaseCleaner.clean_with(:truncation)


all_suns = RestClient.get('https://zodiacal.herokuapp.com/api')
suns_array = JSON.parse(all_suns)

suns_array.each do |hash|
  Sun.create!(sign: hash["name"], start_date: hash["sun_dates"].first,
  end_date: hash["sun_dates"].last, compat_signs: hash["compatibility"].map { |item| item.strip || item }.join(", "), keywords: hash["keywords"].join(", "), symbol: hash["symbol"], element: hash["element"],vibe: hash["vibe"])
end

# zodiacs_array.each do |hash|
#   Zodiac.create(sign: hash["name"], start_date: hash["sun_dates"].first,
#   end_date: hash["sun_dates"].last, keywords: hash["keywords"].join(", "),
#   symbol: hash["symbol"], element: hash["element"], quality: hash["cardinality"],
#   vibe: hash["vibe"], mental_traits: hash["mental_traits"].join(", "),
#   physical_traits: hash["physical_traits"].join(", "))
# end

# Sun.all.map { |sun|
#   sun.compatibilities.push(sun)
# }
# ^^ figure out how to implement adding a users sun_sign to their compatibilities
# array without association type mismatch (currently compatibility requires that
# the ids be unique --> will have to update match method to look out that the matches
# it is creating include all users with sun_sign same as theirs but dont include the
# instance of themselves)

# Sun.all.map { |sun| sun.compat_signs }
# Sun.all.map do |sun|
#   sun.compat_signs.split(',').map{|item| item.strip}.join(', ').split(',')
# end

User.create!(first_name: "Holly", last_name: "Holmes", birth_year: 1989, birth_month: 8, birth_day: 2, gender: "F", gender_pref: "M")
# User.create!(first_name: "Eliza", last_name: "Harris", birth_year: 1992, birth_month: 5, birth_day: 1, gender: "F", gender_pref: "F")
# User.create!(first_name: "Dana", last_name: "Heimlin", birth_year: 1957, birth_month: 8, birth_day: 31, gender: "F", gender_pref: "F")
User.create!(first_name: "Beau", last_name: "Holland", birth_year: 1953, birth_month: 6, birth_day: 2, gender: "M", gender_pref: "F")
User.create!(first_name: "Joel", last_name: "Gaines", birth_year: 1989, birth_month: 6, birth_day: 13, gender: "M", gender_pref: "M")
# User.create!(first_name: "Jim", last_name: "Vidal", birth_year: 1991, birth_month: 11, birth_day: 7, gender: "M", gender_pref: "M")
# User.create!(first_name: "John", last_name: "Samuels", birth_year: 1983, birth_month: 1, birth_day: 15, gender: "M", gender_pref: "M")

User.all.each { |user| user.find_matches }

# 10.times {
#   User.create!(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28))
# }

# 5.times {
#   User.create!(first_name: Faker::Name.female_first_name, last_name: Faker::Name.last_name, birth_year: Faker::Number.between(1977, 1997), birth_month: Faker::Number.between(1, 12), birth_day: Faker::Number.between(1, 28))
# }
#
# 5.times {
#   User.create!(first_name: Faker::Name.male_first_name , last_name: Faker::Name.last_name, birth_year: Faker::Number.between(1977, 1997), birth_month: Faker::Number.between(1, 12), birth_day: Faker::Number.between(1, 28))
# }


def create_compatibilities(sun_sign)
  Sun.all.map do |sun|
    if sun.compat_signs.include?(sun_sign.sign)
      Compatibility.find_or_create_by(sun_id: sun.id, compatible_sun_id: sun_sign.id)
    end
  end
end

sun_sign_array = Sun.all
sun_sign_array.each { |sun_sign| create_compatibilities(sun_sign) }
