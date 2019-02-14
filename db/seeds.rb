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


User.create!(email: 'holly@h.com', password: '123456', first_name: "Holly", last_name: "Holmes", birth_year: 1989, birth_month: 8, birth_day: 2, gender: "F", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832413/pexels-woman1.jpg')
User.create!(email: 'eliza@e.com', password: '123456', first_name: "Eliza", last_name: "Harris", birth_year: 1992, birth_month: 5, birth_day: 1, gender: "F", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832420/pexels-woman3.jpg')
User.create!(email: 'dana@d.com', password: '123456', first_name: "Dana", last_name: "Heimlin", birth_year: 1987, birth_month: 8, birth_day: 31, gender: "F", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1549822242/profile-images/pexels-woman2_xsgfyb.jpg")
User.create!(email: 'beau@b.com', password: '123456', first_name: "Beau", last_name: "Holland", birth_year: 1983, birth_month: 6, birth_day: 2, gender: "M", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1549822219/profile-images/pexels-man3_cbabkx.jpg")
User.create!(email: 'joel@j.com', password: '123456', first_name: "Joel", last_name: "Gaines", birth_year: 1989, birth_month: 6, birth_day: 13, gender: "M", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1549823708/profile-images/pexels-man5_ebhhxr.jpg")
User.create!(email: 'jim@j.com', password: '123456', first_name: "Jim", last_name: "Vidal", birth_year: 1991, birth_month: 11, birth_day: 7, gender: "M", gender_pref: "M, F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549823632/profile-images/pexels-man2_eymz9r.jpg')
User.create!(email: 'john@j.com', password: '123456', first_name: "John", last_name: "Samuels", birth_year: 1983, birth_month: 1, birth_day: 15, gender: "M", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549824820/profile-images/pexels-man4_kuokxs.jpg')
User.create!(email: 'celia@c.com', password: '123456', first_name: 'Celia', last_name: 'George', birth_year: 1994, birth_month: 4, birth_day: 16, gender: 'F', gender_pref: 'M', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832443/pexels-woman9.jpg')
User.create!(email: 'wes@w.com', password: '123456', first_name: 'Wes', last_name: 'Jamal', birth_year: 1984, birth_month: 5, birth_day: 1, gender: 'M', gender_pref: 'M', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832780/pexels-man7.jpg')
User.create!(email: 'lane@l.com', password: '123456', first_name: 'Lane', last_name: 'van Willems', birth_year: 1990, birth_month: 7, birth_day: 3, gender: 'F', gender_pref: 'M, F', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832791/pexels-woman6.jpg')

User.all.each { |user| user.find_matches }

# users =
# 10.times {
#   User.create!(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)), gender: , gender_pref: , location: , bio: Faker::Lorem.paragraph
# }
#
# users = 10.times {
#     {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_day: FFaker::Random.rand(1..28), birth_month: FFaker::Random.rand(0..12), birth_year: FFaker::Random.rand(1977..1997), bio: Faker::Lorem.paragraph}
#   }

# users = [
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
#   {first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name, birth_year: FFaker::Random.rand(1977..1997), birth_month: FFaker::Random.rand(0..12), birth_day: FFaker::Random.rand(1..28)},
# ]

# User.all.each { |user| user.find_matches }


def create_compatibilities(sun_sign)
  Sun.all.map do |sun|
    if sun.compat_signs.include?(sun_sign.sign)
      Compatibility.find_or_create_by(sun_id: sun.id, compatible_sun_id: sun_sign.id)
    end
  end
end

sun_sign_array = Sun.all
sun_sign_array.each { |sun_sign| create_compatibilities(sun_sign) }
