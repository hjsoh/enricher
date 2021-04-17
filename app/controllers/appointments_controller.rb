class AppointmentsController < ApplicationController
  def index
    @appointments = policy_scope(Appointment)
  end

  def new
    @appointment = Appointment.new
    authorize @appointment
  end

  def create
    @appointment = Appointment.new
    @appointment.user = current_user
    authorize @appointment
    if @appointment.save!
      redirect_to office_hours_path, alert: "Created new office hour appointment"
    else
      render :new
    end
  end
end
