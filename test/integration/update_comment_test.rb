require 'test_helper'

class UpdateCommentTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test 'update comment' do
    put "/api/comments/#{@comment.id}", {
      comment: {
        body: 'Uh oh.'
      }
    }.to_json,
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 204, response.status
    assert_equal 'Uh oh.', Comment.find(@comment.id).body
  end
end
