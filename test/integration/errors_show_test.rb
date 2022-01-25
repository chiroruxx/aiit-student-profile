require "test_helper"

class ErrorsShowTest < ActionDispatch::IntegrationTest
  test 'show error page' do
    get '/404'
    assert_equal 404, status
    assert_template 'errors/show'
  end
end
