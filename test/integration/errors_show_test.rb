require "test_helper"

class ErrorsShowTest < ActionDispatch::IntegrationTest
  test 'show error page' do
    get '/404'
  end
end
