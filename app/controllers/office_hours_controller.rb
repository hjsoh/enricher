class OfficeHoursController < ApplicationController
  def index
    @office_hours = policy_scope(OfficeHour)
  end
end
