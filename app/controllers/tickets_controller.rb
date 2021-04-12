class TicketsController < ApplicationController
  include Pundit

  def index
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
    @classroom = Classroom.find(params[:classroom_id])
    @ticket = Ticket.new
    authorize @ticket
    authorize @classroom
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @classroom = Classroom.find(params[:classroom_id])

    @ticket.is_private = true
    @ticket.status = "open"

    @ticket.user = current_user
    @ticket.classroom = @classroom

    authorize @ticket


    #need one for teacher, one for parent. doing for parent now
    if @ticket.save
      redirect_to classroom_tickets_path(@classroom)
    else
      render :new
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
    params.require(:ticket).permit(:question, :academic_year, :user_id, :classroom_id, :category_name, :is_private, :status)
  end
end
