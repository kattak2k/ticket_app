require 'test_helper'

class CreateCommentTest < ActionDispatch::IntegrationTest
  setup do
    project = Project.create!(name: 'Project One')
    @ticket = project.tickets.create!(subject: 'Test Issue', description: 'This is a test.')
  end

  test 'create ticket with valid data' do
    post "/api/tickets/#{@ticket.id}/comments", {
      comment: {
        ticket_id: @ticket.id,
        content: 'Something broke.'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    comment = json(response.body)[:comment]
    assert_equal api_comment_url(comment[:id]), response.location
    assert_equal @ticket.id, comment[:ticket_id]
    assert_equal 'Something broke.', comment[:content]
  end

  test 'does not create ticket with invalid data' do
    post "/api/tickets/#{@ticket.id}/comments", {
      comment: {
        ticket_id: @ticket.id,
        content: nil
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
