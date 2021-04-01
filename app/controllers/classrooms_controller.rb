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
    authorize @classroom

    @classroom.user = current_user
    @classroom.is_active = true

    if @classroom.save
      redirect_to classroom_path(@classroom)
    else
      render :new
    end
  end

  def show
    @classroom = Classroom.find(params[:id])
    @message = Message.new()
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
