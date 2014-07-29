class Api::CommentsController < Api::BaseController

  def index
    if ticket_id = params[:ticket_id]
      comments = Comment.where(ticket_id: ticket_id)
    elsif ids = params[:ids]
      comments = Comment.find(ids)
    else
      comments = Comment.all
    end
    respond_with comments
  end

  def show
    comment = Comment.find(params[:id])
    respond_with comment
  end

  def create
    comment = Comment.create(comment_params)
    respond_with :api, comment
  end

  def update
     comment = Comment.find(params[:id])
     comment.update(comment_params)
     respond_with comment
  end

  def destroy
    comment = Comment.find(params[:id])
    respond_with comment.destroy
  end

  def comment_params
    params.require(:comment).permit(:ticket_id, :name, :body)
  end
end
