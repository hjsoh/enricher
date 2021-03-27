# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Create test account for teacher"

teacher_test = User.create!(email: 'teacher_test@hotmail.com',
                            password: '123456',
                            name: Faker::Name.name,
                            role: 'teacher')

puts "Finished creating test account for teacher"

puts "Create test account for parent"

parent_test = User.create!(email: 'parent_test@hotmail.com',
                            password: '123456',
                            name: Faker::Name.name,
                            role: 'parent')
  test_student = Student.new(name: Faker::Name.name)
  test_student.guardianship.

puts "Finished creating test account for parent"


