class UserController < ApplicationController
  def dashboard
    @user = current_user
    @stories = @user.stories.order(:id)
  end
end
