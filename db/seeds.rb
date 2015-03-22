# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
    )
end

20.times do
  Good.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraphs(2),
    user_id: Faker::Number.number(2)
    )
end
