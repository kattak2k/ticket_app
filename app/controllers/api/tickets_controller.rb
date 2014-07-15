class Api::TicketsController < Api::BaseController
  def index
    tickets = Ticket.where(project_id: params[:project_id])
    respond_with tickets
  end

  def create
    project = Project.find(params[:project_id])
    ticket = Ticket.create(ticket_params)
    respond_with :api, project, ticket
  end

  def ticket_params
    params.require(:ticket).permit(:project_id, :subject, :description, :priority, :status)
  end
end
