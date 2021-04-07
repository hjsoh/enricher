class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      if current_user.role == 'parent'

        @navbar = true
        @footer = true

        render :parent
      else
        render :teacher
      end
    else
      redirect_to new_user_session_path
    end
  end
end
