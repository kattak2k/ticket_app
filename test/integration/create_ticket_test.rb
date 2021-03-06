require 'test_helper'

class CreateTicketTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test 'create ticket with valid data' do
    post "/api/tickets", {
      ticket: {
        project_id: @project.id,
        subject: 'Test Issue',
        description: 'This is a test issue.'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    ticket = json(response.body)[:ticket]
    assert_equal api_ticket_url(ticket[:id]), response.location
    assert_equal @project.id, ticket[:project_id]
    assert_equal 'Test Issue', ticket[:subject]
  end

  test 'does not create ticket with invalid data' do
    post "/api/tickets", {
      ticket: {
        project_id: @project.id,
        name: nil,
        description: nil
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
