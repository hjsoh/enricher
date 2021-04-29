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



# ----------REALISTIC SEEDS FOR DEMO DAY------------

puts "Creating Hwa parent"

hwa = User.create!(
  email: "soh_hwajie@hotmail.com",
  password: '123456',
  name: "Hwa Jie Soh",
  role: 'parent'
)

puts "Creating 2 students for Hwa"
hwa_student1 = Student.new(
    name: "#{Faker::Name.first_name} Soh",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
hwa_student1.parents << hwa
hwa_student1.save!

hwa_student2 = Student.new(
    name: "#{Faker::Name.first_name} Soh",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
hwa_student2.parents << hwa
hwa_student2.save!

puts "Creating ZK parent"

zk = User.create!(
  email: "wzhikai@gmail.com",
  password: '123456',
  name: "Zhi Kai Wong",
  role: 'parent'
)

puts "Creating 2 students for ZK"
zk_student1 = Student.new(
    name: "#{Faker::Name.first_name} Wong",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
zk_student1.parents << zk
zk_student1.save!

zk_student2 = Student.new(
    name: "#{Faker::Name.first_name} Wong",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
zk_student2.parents << zk
zk_student2.save!

puts "Creating Margo parent"

margo = User.create!(
  email: "margarita.maltseva@protonmail.com",
  password: '123456',
  name: "Margarita Maltseva",
  role: 'parent'
)

puts "Creating 3 students for Margo"

margo_student1 = Student.new(
    name: "#{Faker::Name.first_name} Maltseva",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
margo_student1.parents << margo
margo_student1.save!

margo_student2 = Student.new(
    name: "#{Faker::Name.first_name} Maltseva",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
margo_student2.parents << margo
margo_student2.save!

margo_student3 = Student.new(
    name: "#{Faker::Name.first_name} Maltseva",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
margo_student3.parents << margo
margo_student3.save!

puts "Creating Ann parent"

ann = User.create!(
  email: "ann@wagon.com",
  password: '123456',
  name: "Ann Koh",
  role: 'parent'
)

puts "Creating 1 student for Ann"

ann_student1 = Student.new(
    name: "#{Faker::Name.first_name} Koh",
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
ann_student1.parents << ann
ann_student1.save!

demo_students = []
[hwa_student1, zk_student1, margo_student1, ann_student1].each do |s|
  demo_students << s
end

puts "Creating Shu teacher"

shu = User.create!(
  email: "shu.lim27@gmail.com",
  password: '123456',
  name: "Shu-Yi Lim",
  role: 'teacher'
)

puts "Creating 5 classrooms for Shu"

shu_classroom1 = Classroom.new(
  name: "1A - English",
  is_active: true,
  academic_year: "AY-2021"
)
shu_classroom1.user = shu
shu_classroom1.save!

shu_classroom2 = Classroom.new(
  name: "#{(1..3).to_a.sample}#{('A'..'D').to_a.sample} - Science",
  is_active: true,
  academic_year: "AY-#{(2016..2021).to_a.sample}"
)
shu_classroom2.user = shu
shu_classroom2.save!

shu_classroom3 = Classroom.new(
  name: "#{(1..3).to_a.sample}#{('A'..'D').to_a.sample} - Science",
  is_active: true,
  academic_year: "AY-#{(2016..2021).to_a.sample}"
)
shu_classroom3.user = shu
shu_classroom3.save!

shu_classroom4 = Classroom.new(
  name: "#{(1..3).to_a.sample}#{('A'..'D').to_a.sample} - Science",
  is_active: true,
  academic_year: "AY-#{(2016..2021).to_a.sample}"
)
shu_classroom4.user = shu
shu_classroom4.save!

shu_classroom5 = Classroom.new(
  name: "#{(1..3).to_a.sample}#{('A'..'D').to_a.sample} - Science",
  is_active: true,
  academic_year: "AY-#{(2016..2021).to_a.sample}"
)
shu_classroom5.user = shu
shu_classroom5.save!

# Place demo_students into shu_classroom1 (1A - English)

demo_students.each do |s|
  s.classrooms << shu_classroom1
end


puts "Creating admin account"

admin = User.create!(
  email: 'admin@wagon.com',
  password: '123456',
  name: Faker::Name.unique.name,
  role: 'teacher',
  admin: true
  )

puts "Successfully created admin account"

# ------------- GENERIC SEEDS -------------

puts "Creating 100 students"

100.times do
  student = Student.new(
    name: Faker::Name.unique.name,
    is_active: true,
    admission_year: (2018..2021).to_a.sample
  )
  student.save!
end

puts "Successfully created 100 students"

puts "Creating 60 parents"

60.times do |index|
  parent = User.create!(
    email: "parent#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'parent'
  )
end

parents_array = User.all.where(role:"parent").to_a
parents_hide = []
[zk, margo, hwa, ann].each do |p|
  parents_hide << p
end
parents_npc = parents_array - parents_hide

puts "Successfully created 60 parent accounts"

puts "Linking students to parents"

Student.all.each do |student|
  (1..2).to_a.sample.times do
    student.parents << parents_npc.sample #how does this link into guardianships?
  end
end

puts "Successfully linked students to parents"

puts "Creating 10 teachers"

10.times do |index|
  teacher = User.create!(
    email: "teacher#{index + 1}@gmail.com",
    password: '123456',
    name: Faker::Name.unique.name,
    role: 'teacher'
  )
end

teachers_array = User.all.where(role:"teacher").to_a
teachers_hide = []
teachers_hide << shu
teachers_npc = teachers_array - teachers_hide

puts "Successfully created 10 teacher accounts"

puts "Create 15 classrooms"

15.times do
  classroom = Classroom.new(
    name: "#{(1..6).to_a.sample}#{('A'..'H').to_a.sample} - #{['English', 'Chinese', 'Maths', 'Science'].sample}",
    is_active: [true, false].sample,
    academic_year: "AY-#{(2016..2021).to_a.sample}"
  )
  classroom.user = teachers_npc.sample
  classroom.save!
end

puts "Successfully created 15 classrooms attributed with teachers"


puts "Linking student to classroom"

Student.all.each do |student|
  student.classrooms << Classroom.all.where(is_active:true).sample
end

puts "Successfully linked student to classroom"

# ------------- SEEDS FOR OFFICE HOURS -------------

puts "Seeding 15 office hours for Shu"

15.times do
  start_time = Faker::Time.between_dates(from: '2021-04-20', to: '2021-05-30', period: :evening)
  oh = OfficeHour.new(
    start_time: start_time,
    end_time: start_time + 15.minutes
    )
  oh.user = shu
  oh.save!
end

puts "Successfully seeded 15 office hours for Shu"

puts "Seeding 5 appointments for Shu"

oh = shu.office_hours.sample(5)

oh.each do |element|
  parent = User.all.where(role:'parent').sample
  Appointment.create(
    user: parent,
    office_hour: element,
    name: "#{parent.name} : #{shu.name}"
    )
end

puts "Successfully seeded 5 appointments for Shu"


# puts "Seeding 50 tickets"

# 50.times do
#   ticket = Ticket.new(
#     question: [
#       "How come your english so bad?",
#       "Why is my child so dumb?",
#       "Why is my child so short?",
#       "Why is my child so fat?",
#       "Why you dont like chinese kids?",
#       "Issit because I poor?",
#       "What is that cute girl's number?",
#       "Why you so smelly?"
#     ].sample,
#     status: ['Not yet started', 'In progress', 'Completed'].sample,
#     category_name: ['Attendance', 'Enrollment', 'Adhoc', 'Homework', 'Syllabus', 'Timetable', 'Welfare'].sample,
#     is_private: [true, false].sample
#   )
#   ticket.classroom = Classroom.all.where(is_active:true).sample
#   ticket.user = User.all.where(role:'parent').sample
#   ticket.save!
# end

# puts "Successfully seeded 100 tickets"


# puts "Seeding 30 office hours per teacher"

# teachers = User.all.where(role:'teacher')

# teachers.each do |teacher|
#   30.times do
#     start_time = Faker::Time.between_dates(from: '2021-01-01', to: '2021-12-31', period: :afternoon)
#     oh = teacher.office_hours.build(
#       start_time: start_time,
#       end_time: start_time + 15.minutes
#       )
#     oh.save!
#   end
# end

# puts "Successfully seeded 30 office hours per teacher"


# puts "Seeding 30 office hours for test teacher"

# 30.times do
#   start_time = Faker::Time.between_dates(from: '2021-01-01', to: Date.today, period: :afternoon)
#   oh = OfficeHour.new(
#     start_time: start_time,
#     end_time: start_time + 15.minutes
#     )
#   oh.user = User.find_by(email: "teacher_test@hotmail.com")
#   oh.save!
# end

# puts "Successfully seeded 30 office hours for test teacher"


# puts "Seeding 100 appointments"

# oh = OfficeHour.all.sample(100)

# oh.each do |element|
#   parent = User.all.where(role:'parent').sample
#   Appointment.create(
#     user: parent,
#     office_hour: element,
#     name: "#{parent.name} : #{element.user.name}"
#     )
# end

# puts "Successfully seeded 100 appointments"


# puts "Seeding 10 announcements"

# 10.times do
#   announcement = Announcement.new(
#     title: [
#       "Bring thermometers to school tomorrow.",
#       "There will be a substitute teacher taking over this class.",
#       "Please remind your child to wear deodorant.",
#       "Tiktok dancing in class will not be tolerated."].sample,
#     content: [
#       "Don't disappoint me.",
#       "Behave.",
#       "Why did you bear a child anyway."].sample
#   )
#   assignment = []
#   rand(1..5).times do |x|
#     assign = Classroom.all.where(is_active:true).sample
#     assignment << assign
#   end
#   announcement.classrooms = assignment
#   announcement.save!
# end

# puts "Successfully seeded 10 announcements"
