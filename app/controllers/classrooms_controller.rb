class ClassroomsController < ApplicationController
  include Pundit

  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :roster]

  def index
    @classrooms = policy_scope(Classroom).order(created_at: :desc)
  end

  def new
    @classroom = Classroom.new
    authorize @classroom
  end

  def create
    @classroom = Classroom.new(classroom_params)
    @classroom.is_active = true
    @classroom.save
    authorize @classroom

    redirect_to classroom_path(@classroom)
  end

  def show
  end

  def edit
  end

  def update
    @classroom.update(classroom_params)

    redirect_to classroom_path(@classroom)
  end

  def destroy
    @classroom.destroy

    redirect_to classrooms_path
  end

  def roster
    @enrollments = Enrollment.where(classroom_id: @classroom.id)

    authorize @enrollments
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
    authorize @classroom
  end

  def classroom_params
    params.require(:classroom).permit(:name, :academic_year, :user_id)
  end
end