class Api::CommentsController < Api::BaseController
  def create
    comment = Comment.create(comment_params)
    respond_with :api, comment
  end

  def comment_params
    params.require(:comment).permit(:ticket_id, :content)
  end
end
