# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
User.create
  name:  "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: 1

20.times do |n|
  name  = Faker::Name.name
  email = "FakeUser#{n+1}@railstutorial.org"
  password = "password"
  User.create
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: 0,
    activated: true
end
