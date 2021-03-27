class Api::V1::ClassroomsController < Api::V1::BaseController
  before_action :set_classroom, only: [ :show ]

  def index
    @classrooms = policy_scope(Classroom)
  end

  def show
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
    authorize @classroom
  end
end
