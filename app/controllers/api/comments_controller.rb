class Api::CommentsController < Api::BaseController
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
    params.require(:comment).permit(:ticket_id, :content)
  end
end
