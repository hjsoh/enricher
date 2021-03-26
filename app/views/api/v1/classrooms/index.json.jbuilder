json.array! @classrooms do |classroom|
  json.extract! classroom, :id, :name, :academic_year
end
