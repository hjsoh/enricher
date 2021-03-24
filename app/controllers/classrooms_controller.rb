class ClassroomsController < ApplicationController
  include Pundit
  def index
    @classrooms = policy_scope(Classroom).order(created_at: :desc)
  end

  def new
    @classroom = Classroom.new
    authorize @classroom
  end
end
