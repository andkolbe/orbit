# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create main test user
User.create(name: "Test User", email: "test@testuser.com", password: "password", password_confirmation: "password")

# Bulk generate test users
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@testuser.org"
    password = "password"
    User.create!(name: name, email: email, password: password, password_confirmation: password)
end