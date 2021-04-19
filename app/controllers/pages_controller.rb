class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      if current_user.role == 'parent'

        @navbar = true
        @footer = true

        @user = current_user
        @announcements = @user.student_announcements.order(created_at: :desc)
        @tickets = @user.tickets.where.not(status: 'Completed').order(created_at: :desc)
        @appointments = @user.appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')
        render :parent
      else
        @user = current_user
        @announcements = @user.announcements.order(created_at: :desc)
        @tickets = @user.teacher_tickets.where.not(status: 'Completed').order(created_at: :desc)
        @appointments = @user.teacher_appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')
        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
