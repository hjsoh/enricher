# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Cleaning database"
Ticket.destroy_all
Classroom.destroy_all
Student.destroy_all
User.destroy_all

puts "Successfully cleaned up database"


puts "Create test account for teacher"

teacher_test = User.create!(
  email: 'teacher_test@hotmail.com',
  password: '123456',
  name: Faker::Name.unique.name,
  role: 'teacher'
  )

puts "Finished creating test account for teacher"


puts "Creating 50 students"

50.times do
  student = Student.create!(
    name: Faker::Name.unique.name
  )
end

puts "Finished 50 students"


puts "Creating 50 parents"

50.times do |index|
  parent = User.create!(
    email: "parent#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'parent'
  )
end

puts "Finished creating 50 parent accounts"


puts "Linking students to parents"

Student.all.each do |student|
  (1..2).to_a.sample.times do
    student.parents << User.all.where(role:'parent').order('RANDOM()') #how does this link into guardianships?
  end
end

puts "Finished linking students to parents"


puts "Creating 50 teachers"

50.times do |index|
  parent = User.create!(
    email: "teacher#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'teacher'
  )
end

puts "Finished creating 50 teacher accounts"


puts "Create 60 classrooms"

60.times do
  classroom = Classroom.new(
    name: "#{(1..6).to_a.sample}#{('A'..'H').to_a.sample} - #{['English', 'Chinese', 'Maths', 'Science'].sample}",
    is_active: [true, false].sample,
    academic_year: "AY-#{(2016..2021).to_a.sample}"
  )
  classroom.user = User.all.where(role:'teacher').sample
  classroom.save!
end

puts "Create 60 classrooms attributed with teachers"


puts "Linking student to classroom"

Student.all.each do |student|
  (1..2).to_a.sample.times do
    student.classrooms << Classroom.all.where(is_active:true).sample
  end
end

puts "Finished linking student to classroom"


puts "Seeding 100 tickets"

100.times do
  ticket = Ticket.new(
    question: [
      "How come your english so bad?",
      "Why is my child so dumb?",
      "Why is my child so short?",
      "Why is my child so fat?",
      "Why you dont like chinese kids?",
      "Issit because I poor?",
      "What is that cute girl's number?",
      "Why you so smelly?"
    ].sample,
    status: ['Not yet started', 'In progress', 'Completed'].sample,
    category_name: ['Attendance', 'Enrollment', 'Adhoc', 'Homework', 'Syllabus', 'Timetable', 'Welfare'].sample,
    is_private: [true, false].sample
  )
  ticket.classroom = Classroom.all.where(is_active:true).sample
  ticket.user = User.all.where(role:'parent').sample
  ticket.save!
end

puts "Successfully seeded 100 tickets"


puts "Seeding 100 office hours"

teachers = User.all.where(role:'teacher')

teachers.each do |teacher|
  oh = teacher.office_hours.build(
    date: Faker::Date.between(from: '2020-01-01', to: '2021-03-31'),
    start_time: '14:00',
    end_time: '14:30'
    )
  oh.save!
end

puts "Successfully seeded 100 office hours"


puts "Seeding 50 appointments"

oh = OfficeHour.all.limit(50)

oh.each do |element|
  Appointment.create(
    user: User.all.where(role:'parent').sample,
    office_hour: element
    )
end

puts "Successfully seeded 50 appointments"


