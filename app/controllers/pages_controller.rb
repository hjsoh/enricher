class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
        # @navbar = true
        # @footer = true
        @user = current_user

      if current_user.role == 'parent'
        @classrooms = []
        @announcements = []
        @user.students.each do |s|
          s.classrooms.each do |c|
            @classrooms << c
          end
        end
        @classrooms.each do |c|
          @announcements << c.announcements
        end
        render :parent
      else
        @announcements = @user.announcements.order(created_at: :desc).first(4)
        @tickets = @user.tickets.order(created_at: :desc).first(4)
        @office_hours = @user.office_hours.order(created_at: :desc).first(4)
        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
