class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      @user = current_user
      if current_user.role == 'parent'

        @navbar = true
        @footer = true

        @user = current_user
        @announcements = @user.student_announcements.order(created_at: :desc)
        @unread_announcements = @user.student_announcements.where("created_at >= ?", @user.last_sign_in_at)
        raise
        @tickets = @user.tickets.where.not(status: 'Completed').order(created_at: :desc)
        @appointments = @user.appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')
        render :parent
      else
        @user = current_user
        @announcements = @user.announcements.order(created_at: :desc)
        @classrooms = @user.classrooms
        @classroom_announcements = []
        @classrooms.each do |classroom|
          if !classroom.classroom_announcements.empty?
            @classroom_announcements << classroom.classroom_announcements
          end
        end
        @filtered_announcements = @classroom_announcements.flatten

        @unread_announcements = @filtered_announcements.reject{ |announcement| announcement.created_at <= @user.last_sign_in_at }

        @tickets = @user.teacher_tickets.where.not(status: 'Completed').order(created_at: :desc)
        @appointments = @user.teacher_appointments.joins(:office_hour).where("office_hours.start_time > ?", DateTime.now).order('office_hours.start_time ASC')

        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
