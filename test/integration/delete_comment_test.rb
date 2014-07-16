require 'test_helper'

class DeleteCommentTest < ActionDispatch::IntegrationTest
  setup do
    project = Project.create!(name: 'Test Project')
    ticket = project.tickets.create!(subject: 'Test Issue', description: 'This is a test.')
    @comment = ticket.comments.create!(content: 'Something broke.')
  end

  test 'delete comment' do
    delete "/api/comments/#{@comment.id}"
    assert_equal 204, response.status
  end
end
