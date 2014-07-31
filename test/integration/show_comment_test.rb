require 'test_helper'

class ShowCommentTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test 'show_comment' do
    get "/api/comments/#{@comment.id}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    comment = json(response.body)[:comment]
    assert_equal @comment.id, comment[:id]
    assert_equal @comment.ticket_id, comment[:ticket_id]
    assert_equal @comment.name, comment[:name]
    assert_equal @comment.body, comment[:body]
  end
end
