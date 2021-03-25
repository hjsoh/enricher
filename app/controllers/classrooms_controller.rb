class ClassroomsController < ApplicationController
  include Pundit
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
    @classroom = Classroom.find(params[:id])
    authorize @classroom
  end

  def edit
    @classroom = Classroom.find(params[:id])
    authorize @classroom
  end

  def update
    @classroom = Classroom.find(params[:id])
    @classroom.update(classroom_params)
    authorize @classroom

    redirect_to classroom_path(@classroom)
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    @classroom.destroy
    authorize @classroom

    redirect_to classrooms_path
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :academic_year, :user_id)
  end
end
