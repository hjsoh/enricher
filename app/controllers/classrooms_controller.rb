class ClassroomsController < ApplicationController
  include Pundit

  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :roster]

  def index
    @classrooms = policy_scope(Classroom).order(name: :asc)
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
    @announcements = @classroom.announcements
    @tickets = @classroom.tickets.where.not(status: 'Completed').order(created_at: :desc)
    @students = @classroom.students.where(is_active: true).order('name ASC')
    @class_roster = @classroom.students.where(is_active: true).order('name ASC')
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

  def chatrooms
    # find all classrooms by this user
    if current_user.role == 'teacher'
      @classrooms = current_user.classrooms.order('name ASC')
    else
      @classrooms = current_user.student_classrooms.order('name ASC')
    end
    authorize(@classrooms)
    @message = Message.new
  end

  def show_chat
    if current_user.role == 'teacher'
      @classrooms = current_user.classrooms.order('name ASC')
    else
      @classrooms = current_user.student_classrooms.order('name ASC')
    end
    @classroom = Classroom.find(params[:classroom_id])
    @classroom_announcements = @classroom.classroom_announcements.where("created_at >= ?", 1.days.ago)
    authorize @classroom_announcements
    @message = Message.new
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
