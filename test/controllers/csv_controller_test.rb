require 'test_helper'

class CsvControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get csv_new_url
    assert_response :success
  end

  test 'should get create' do
    get csv_create_url
    assert_response :success
  end
end
