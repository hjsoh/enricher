class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @user = current_user
      if current_user.role == 'parent'
        @announcements = @user.student_announcements.order(created_at: :desc).first(4)
        @tickets = @user.tickets.order(created_at: :desc).first(4)
        @office_hours = @user.student_appointments.order(created_at: :desc).first(4)
        render :parent
      else
        @announcements = @user.announcements.order(created_at: :desc).first(4)
        @tickets = @user.teacher_tickets.order(created_at: :desc).first(4)
        @office_hours = @user.office_hours.order(created_at: :desc).first(4)
        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
