require 'test_helper'

class DeleteCommentTest < ActionDispatch::IntegrationTest
  setup do
    ticket = tickets(:one)
    @comment = ticket.comments.create!(name: 'Sam', body: 'Something broke.')
  end

  test 'delete comment' do
    delete "/api/comments/#{@comment.id}"
    assert_equal 204, response.status
  end
end
