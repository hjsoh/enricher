class OfficeHoursController < ApplicationController
  def index
    start_date = params.fetch(:start_time, Date.today).to_date
    @office_hours = policy_scope(OfficeHour)
  end

  def new
    @office_hour = OfficeHour.new
    authorize @office_hour
  end

  def create
    @office_hour = OfficeHour.new(office_hour_params)
    end_time = @office_hour.start_time + 15.minutes
    @office_hour.end_time = end_time
    @office_hour.user = current_user
    authorize @office_hour
    if @office_hour.save!
      redirect_to office_hours_path, alert: "Created new office hour"
    else
      render :new
    end
  end

  def appointment
    @office_hour = OfficeHour.find(params[:id])
    @appointment = Appointment.new
    @appointment.office_hour = @office_hour
    @appointment.user = current_user
    @appointment.name = "#{current_user.name} : #{@office_hour.user.name}"
    authorize @appointment
    @appointment.save!
  end

  def edit
    @office_hour = OfficeHour.find(params[:id])
    authorize @office_hour
  end

  def update
    @office_hour = OfficeHour.find(params[:id])
    authorize @office_hour
    if @office_hour.update(office_hour_params)
      end_time = @office_hour.start_time + 15.minutes
      @office_hour.end_time = end_time
      @office_hour.save
      redirect_to office_hours_path, alert: "Edited office hour"
    else
      render :edit
    end
  end

  private

  def office_hour_params
    params.require(:office_hour).permit(:start_time, :office_hour_id)
  end
end
