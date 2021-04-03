class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      @banner = true
      # render :home --> this now routes to _banner partial
    else
      @splash = true
      # render :splash --> this now routes to _splash partial
    end
  end
end
