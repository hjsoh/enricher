class TicketsController < ApplicationController
  include Pundit

  def index
    # @ticket = Ticket.new

    if params[:query].present?
      @tickets = Ticket.global_search(params[:query])
      skip_policy_scope
      if @tickets.empty?
        flash[:error] = "There are #{@tickets.count} tickets".html_safe
      else
        flash[:notice] = "There are #{@tickets.count} tickets".html_safe
      end
    else
      @tickets = policy_scope(Ticket).order(created_at: :desc)
    end
  end

  def new
    @ticket = Ticket.new
    authorize @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @classroom_ids = ticket_params[:classroom_ids]
    @ticket.user = current_user
    @ticket.status = 'Not yet started'

    authorize @ticket

    if @ticket.save
      redirect_to tickets_path
    else
      redirect_to tickets_path
      flash[:alert] = "Please try again."
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    authorize @ticket
    students = @ticket.user.students
    @names_array = []
    students.each { |s| @names_array << s.name }

    @comment = Comment.new
  end

  def update
    @ticket = Ticket.find(params[:id])
    authorize @ticket
    @ticket.update(ticket_params)

    redirect_to ticket_path(@ticket)
  end

  def done
    @ticket = Ticket.find(params[:id])
    authorize @ticket

    @ticket.status = "done"

    if @ticket.save!
      redirect_to ticket_path(@ticket)
    else
      render :new
    end
  end

  def partial
    @tickets = policy_scope(Ticket).order(created_at: :desc)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:question, :academic_year, :user_id, :category_name, :is_private, :status, :classroom_id)
  end
end
