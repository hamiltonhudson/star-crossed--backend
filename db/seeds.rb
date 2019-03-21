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


def create_compatibilities(sun_sign)
  Sun.all.map do |sun|
    if sun.compat_signs.include?(sun_sign.sign)
      Compatibility.find_or_create_by(sun_id: sun.id, compatible_sun_id: sun_sign.id)
    end
  end
end

sun_sign_array = Sun.all
sun_sign_array.each { |sun_sign| create_compatibilities(sun_sign) }


#ladies
User.create!(email: 'eliza@e.com', password: '123456', first_name: "Eliza", last_name: "Harris", birth_date: "1982-06-03", gender: "F", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832413/pexels-woman1.jpg')
User.create!(email: 'jill@j.com', password: '123456', first_name: "Jill", last_name: "Waterhouse", birth_date: "1981-02-13", gender: "F", gender_pref: "F,M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550181999/pexels-woman2.jpg')
User.create!(email: 'megan@m.com', password: '123456', first_name: "Megan", last_name: "Campbell", birth_date: "1993-06-21", gender: "F", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832420/pexels-woman3.jpg')
User.create!(email: 'jorja@j.com', password: '123456', first_name: "Jorja", last_name: "Marte", birth_date: "1992-05-07", gender: "F", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182008/pexels-woman4.jpg')
User.create!(email: 'holly@h.com', password: '123456', first_name: "Holly", last_name: "Holmes", birth_date: "1989-08-02", gender: "F", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182019/pexels-woman5.jpg')
User.create!(email: 'celia@c.com', password: '123456', first_name: 'Celia', last_name: 'George', birth_date: "1994-04-16", gender: 'F', gender_pref: 'M', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832791/pexels-woman6.jpg')
User.create!(email: 'dana@d.com', password: '123456', first_name: "Dana", last_name: "Heimlin", birth_date: "1978-08-31", gender: "F", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1550182026/pexels-woman7.jpg")
User.create!(email: 'liz@l.com', password: '123456', first_name: "Liz", last_name: "Maroney", birth_date: "1992-10-12", gender: "F", gender_pref: "F,M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1550182036/pexels-woman8.jpg")
User.create!(email: 'daphne@d.com', password: '123456', first_name: "Daphne", last_name: "DuPhraine", birth_date: "1987-09-14", gender: "F", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/c_crop,h_3797/v1549832443/pexels-woman9.jpg")
User.create!(email: 'fiona@f.com', password: '123456', first_name: "Fiona", last_name: "Smuthers", birth_date: "1986-03-19", gender: "F", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1550182047/pexels-woman10.jpg")
User.create!(email: 'lane@l.com', password: '123456', first_name: 'lane', last_name: 'van willems', birth_date: "1990-07-03", gender: 'F', gender_pref: "f,m", location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182053/pexels-woman11.jpg')

#gents
User.create!(email: 'beau@b.com', password: '123456', first_name: "Beau", last_name: "Holland", birth_date: "1983-06-02", gender: "M", gender_pref: "F", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1550181705/pexels-man1.jpg")
User.create!(email: 'joel@j.com', password: '123456', first_name: "Joel", last_name: "Gaines", birth_date: "1989-06-13", gender: "M", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: "https://res.cloudinary.com/ehh/image/upload/v1550182067/pexels-man2.jpg")
User.create!(email: 'jim@j.com', password: '123456', first_name: "Jim", last_name: "Vidal", birth_date: "1991-11-07", gender: "M", gender_pref: "F,M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182075/pexels-man3.jpg')
User.create!(email: 'john@j.com', password: '123456', first_name: "John", last_name: "Samuels", birth_date: "1983-01-15", gender: "M", gender_pref: "M", location: "New York, NY", bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182081/pexels-man4.jpg')
User.create!(email: 'wes@w.com', password: '123456', first_name: 'Wes', last_name: 'Jamal', birth_date: "1984-05-01", gender: 'M', gender_pref: 'M', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182088/pexels-man5.jpg')
User.create!(email: 'george@g.com', password: '123456', first_name: 'George', last_name: 'Sharif', birth_date: "1974-01-14", gender: 'M', gender_pref: 'F', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182096/pexels-man6.jpg')
User.create!(email: 'louis@l.com', password: '123456', first_name: 'Louis', last_name: 'Williamson', birth_date: "1982-09-05", gender: 'M', gender_pref: 'F', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1549832780/pexels-man7.jpg')
User.create!(email: 'mike@m.com', password: '123456', first_name: 'Mike', last_name: 'Grant', birth_date: "1991-08-16", gender: 'M', gender_pref: 'F', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182117/pexels-man8.jpg')
User.create!(email: 'adam@a.com', password: '123456', first_name: 'Adam', last_name: 'Jones', birth_date: "1990-05-29", gender: 'M', gender_pref: 'M, F', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550181964/pexels-man9.jpg')
User.create!(email: 'nick@n.com', password: '123456', first_name: 'Nick', last_name: 'Cohen', birth_date: "1980-04-09", gender: 'M', gender_pref: "F,M", location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182150/pexels-man12.jpg')
User.create!(email: 'alex@a.com', password: '123456', first_name: 'alex', last_name: 'lords', birth_date: "1979-07-12", gender: 'm', gender_pref: 'f', location: 'New York, NY', bio: Faker::Lorem.paragraph, photo: 'https://res.cloudinary.com/ehh/image/upload/v1550182156/pexels-man13.jpg')


User.all.each { |user| user.find_matches }
