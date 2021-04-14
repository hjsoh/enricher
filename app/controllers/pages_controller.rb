class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      # if current_user.role == 'parent'

        @navbar = true
        @footer = true

        # render :parent
      # else
        @user = current_user
        @announcements = @user.announcements.order(created_at: :desc).first(4)
        @tickets = @user.tickets.order(created_at: :desc).first(4)
        @office_hours = @user.office_hours.order(created_at: :desc).first(4)
        render :teacher
      # end
    else
      redirect_to new_user_session_path
    end
  end
end
