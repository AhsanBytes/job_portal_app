# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create a default admin user
admin_email = 'admin@example.com'
admin_password = 'password123'

unless User.exists?(email: admin_email)
  User.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password,
    role: :admin,
    name: 'Default Admin',
    phone_no: '+12 345 678 90'
  )
  puts "Default admin user created."
else
  puts "Default admin user already exists."
end

departments = %w[HR IT Finance Sales Marketing Accounting Business_Administration]
departments.find_each do |name|
  Department.create!(name: name)
end

skills = %w[Ruby JavaScript Python Java HTML CSS SQL]
skills.find_each do |name|
  Skill.create!(name: name)
end
