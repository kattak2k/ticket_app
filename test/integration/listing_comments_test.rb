require 'test_helper'

class ListingCommentsTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test 'listing all comments' do
    get "/api/comments"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal Comment.count, json(response.body)[:comments].size
  end

  test 'listing comments by ticket' do
    get "/api/comments?ticket_id=#{@ticket.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal @ticket.comments.count, json(response.body)[:comments].size
  end

  test 'listing comments by ids' do
    ids = @ticket.comments.pluck(:id)
    get "/api/comments?ids[]=#{ids.join('&ids[]=')}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    assert_equal ids.count, json(response.body)[:comments].size
  end
end
