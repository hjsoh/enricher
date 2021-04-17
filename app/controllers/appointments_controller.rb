class AppointmentsController < ApplicationController
  def index
    @appointments = policy_scope(Appointment)
  end

  def new
    @appointment = Appointment.new
    @office_hour = OfficeHour.find(params[:id])
    @appointment.office_hour = @office_hour
    authorize @appointment
  end

  def create
    @appointment = Appointment.new
    @office_hour = OfficeHour.find(params[:office_hour_id])
    @appointment.office_hour = @office_hour
    @appointment.user = current_user
    @appointment.name = "#{current_user.name} : #{@office_hour.user.name}"

    authorize @appointment
    if @appointment.save!
      redirect_to office_hours_path, alert: "Created new office hour appointment"
    else
      render :new
    end
  end
end
