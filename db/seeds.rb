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
Message.destroy_all
Classroom.destroy_all
Student.destroy_all
Appointment.destroy_all
OfficeHour.destroy_all
Announcement.destroy_all
User.destroy_all

puts "Successfully cleaned up database"


puts "Create test account for teacher"

teacher_test = User.create!(
  email: 'teacher_test@hotmail.com',
  password: '123456',
  name: Faker::Name.unique.name,
  role: 'teacher',
  admin: true
  )

puts "Successfully created test account for teacher"

puts "Creating 10 test classrooms for teacher_test"
  10.times do
  classroom = Classroom.new(
    name: "#{(1..6).to_a.sample}#{('A'..'H').to_a.sample} - #{['English', 'Chinese', 'Maths', 'Science'].sample}",
    is_active: [true, false].sample,
    academic_year: "AY-#{(2016..2021).to_a.sample}"
  )
  classroom.user = User.find_by(email: "teacher_test@hotmail.com")
  classroom.save!
  end


puts "Creating 50 students"

50.times do
  student = Student.create!(
    name: Faker::Name.unique.name,
    admission_year: (2018..2021).to_a.sample
  )
end

puts "Successfully created 50 students"


puts "Creating 50 parents"

50.times do |index|
  parent = User.create!(
    email: "parent#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'parent'
  )
end

puts "Successfully created 50 parent accounts"


puts "Linking students to parents"

Student.all.each do |student|
  (1..2).to_a.sample.times do
    student.parents << User.all.where(role:'parent').sample #how does this link into guardianships?
  end
end

puts "Successfully linked students to parents"


puts "Creating 50 teachers"

50.times do |index|
  teacher = User.create!(
    email: "teacher#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'teacher'
  )
end

puts "Successfully created 50 teacher accounts"


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

puts "Successfully created 60 classrooms attributed with teachers"


puts "Creating 10 test classrooms for teacher_test"

  10.times do
  classroom = Classroom.new(
    name: "#{(1..6).to_a.sample}#{('A'..'H').to_a.sample} - #{['English', 'Chinese', 'Maths', 'Science'].sample}",
    is_active: [true, false].sample,
    academic_year: "AY-#{(2016..2021).to_a.sample}"
  )
  classroom.user = User.find_by(email: "teacher_test@hotmail.com")
  classroom.save!
  end

puts "Successfully created 10 test classrooms for teacher_test"


puts "Linking student to classroom"

Student.all.each do |student|
  (1..2).to_a.sample.times do
    student.classrooms << Classroom.all.where(is_active:true).sample
  end
end

puts "Successfully linked student to classroom"


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


puts "Seeding 30 office hours per teacher"

teachers = User.all.where(role:'teacher')

teachers.each do |teacher|
  30.times do
    start_time = Faker::Time.between_dates(from: '2021-01-01', to: '2021-12-31', period: :afternoon)
    oh = teacher.office_hours.build(
      start_time: start_time,
      end_time: start_time + 15.minutes
      )
    oh.save!
  end
end

puts "Successfully seeded 30 office hours per teacher"


puts "Seeding 30 office hours for test teacher"

30.times do
  start_time = Faker::Time.between_dates(from: '2021-01-01', to: Date.today, period: :afternoon)
  oh = OfficeHour.new(
    start_time: start_time,
    end_time: start_time + 15.minutes
    )
  oh.user = User.find_by(email: "teacher_test@hotmail.com")
  oh.save!
end

puts "Successfully seeded 30 office hours for test teacher"


puts "Seeding 100 appointments"

oh = OfficeHour.all.sample(100)

oh.each do |element|
  parent = User.all.where(role:'parent').sample
  Appointment.create(
    user: parent,
    office_hour: element,
    name: "#{parent.name} : #{element.user.name}"
    )
end

puts "Successfully seeded 100 appointments"


puts "Seeding 20 appointments for test teacher"

oh = User.find_by(email: "teacher_test@hotmail.com").office_hours.sample(20)

oh.each do |element|
  parent = User.all.where(role:'parent').sample
  Appointment.create(
    user: parent,
    office_hour: element,
    name: "#{parent.name} : #{User.find_by(email: "teacher_test@hotmail.com").name}"
    )
end

puts "Successfully seeded 20 appointments for test teacher"


puts "Seeding 10 announcements"

10.times do
  announcement = Announcement.new(
    title: [
      "Bring thermometers to school tomorrow.",
      "There will be a substitute teacher taking over this class.",
      "Please remind your child to wear deodorant.",
      "Tiktok dancing in class will not be tolerated."].sample,
    content: [
      "Don't disappoint me.",
      "Behave.",
      "Why did you bear a child anyway."].sample
  )
  assignment = []
  rand(1..5).times do |x|
    assign = Classroom.all.where(is_active:true).sample
    assignment << assign
  end
  announcement.classrooms = assignment
  announcement.save!
end

puts "Successfully seeded 10 announcements"
