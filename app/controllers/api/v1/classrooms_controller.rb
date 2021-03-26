class Api::V1::ClassroomsController < Api::V1::BaseController
  def index
    @classrooms = policy_scope(Classroom)
  end
end
