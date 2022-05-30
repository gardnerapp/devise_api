class Api::V1::UsersController < ActionController::API
  # Create a model level method to generate the token
  # handle errors in the new action
  # TODO change project name push to git add repo

  def new
    @user = User.new(user_params)
    if @user.save
      render  @user.to_json, status: :accepted
    else
      render :json, status: :unproccesable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit %i[email password password_confirmation]
  end
end
