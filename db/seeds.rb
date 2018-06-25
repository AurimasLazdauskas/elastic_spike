# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed accounts
100.times do
  Account.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email,
                 address: Faker::Address.street_address, balance: rand(0.0...15000).round(2))
end
