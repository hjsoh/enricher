class OfficeHoursController < ApplicationController
  def index
    start_date = params.fetch(:start_time, Date.today).to_date
    @office_hours = policy_scope(OfficeHour).where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
