class AppointmentsController < ApplicationController
  def index
    @appointments = policy_scope(Appointment)
  end
end
