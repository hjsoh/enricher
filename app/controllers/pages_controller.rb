class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @user = current_user
      if current_user.role == 'parent'

        @navbar = true
        @footer = true

        @parent = current_user
        @parent_classrooms = current_user.student_classrooms.where(is_active: true).order(name: :asc)
        @parent_announcements = current_user.student_announcements.order(created_at: :desc)
        @parent_tickets = current_user.tickets.where.not(status: 'Completed').order(created_at: :desc)
        @parent_appointments = current_user.appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')
        render :parent
      else
        @teacher = current_user
        @teacher_classrooms = current_user.classrooms.where(is_active: true).order(name: :asc)
        @teacher_announcements = current_user.announcements.order(created_at: :desc)
        @teacher_tickets = current_user.teacher_tickets.where.not(status: 'Completed').order(created_at: :desc)
        @teacher_appointments = current_user.teacher_appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')
        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
