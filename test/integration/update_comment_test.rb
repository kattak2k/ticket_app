require 'test_helper'

class UpdateCommentTest < ActionDispatch::IntegrationTest
  setup do
    project = Project.create!(name: 'Project One')
    ticket = project.tickets.create!(subject: 'Test Issue', description: 'This is a test.')
    @comment = ticket.comments.create!(content: 'Something broke.')
  end

  test 'update comment' do
    put "/api/comments/#{@comment.id}", {
      comment: {
        content: 'Uh oh.'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Uh oh.', Comment.find(@comment.id).content
  end
end
