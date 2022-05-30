require "test_helper"

module DeviseApi
  class Api::V1::Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @email = 'example12345@example.org'
      @password = 'f00b@rZ9922'
    end

    # TODO create helper method to parse response body, save as instance var

    test 'valid sign_up returns user as json & 200' do
      post api_v1_users_sign_up_path, params: {
        user: {
          email: @email,
          password: @password,
          password_confirmation: @password
        }
      }
      assert_response :ok
      body = JSON.parse(response.body)
      assert body.include?('user')
      assert_not body.include?('errors')
    end

    test 'invalid sign_up returns errors & 404' do
      post api_v1_users_sign_up_path, params: {
        user: {
          email: @email,
          password: @password,
          password_confirmation: 'not the right password'
        }
      }
      assert_response :bad_request
      body = JSON.parse response.body
      assert body.include?('errors')
      assert_not body.include?('user')
    end
  end
end
