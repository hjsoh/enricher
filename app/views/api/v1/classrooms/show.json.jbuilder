json.extract! @classroom, :id, :name, :academic_year
json.enrollments @classroom.enrollments do |enrollment|
  json.extract! enrollment, :id, :student_id, :student
end

