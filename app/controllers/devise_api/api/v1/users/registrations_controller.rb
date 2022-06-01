module DeviseApi
  class Api::V1::Users::RegistrationsController < ActionController::API

    # Create A User
    # POST /api/v1/users/sign_up
    def create
      @user = User.new(user_params)
      if @user.save
        render json: { user: @user.to_json }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :bad_request
      end
    end

    private

    def user_params
      params.require(:user).permit %i[email password password_confirmation]
    end

  end
end
