# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Users
User.create!(
  name:  "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: 1)

20.times do |n|
  name  = Faker::Name.name
  email = "FakeUser#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: 0,
    activated: true)
end

# 5.times do |n|
#   name = "Course #{n+1}"
#   description = "Description #{n+1}"
#   Category.create!(
#     name: name,
#     description: description)
# end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
