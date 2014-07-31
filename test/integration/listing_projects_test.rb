require 'test_helper'

class ListingProjectsTest < ActionDispatch::IntegrationTest
  test 'listing_projects' do
    get '/api/projects'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal Project.count, json(response.body)[:projects].size
  end
end
