class UserController < ApplicationController
before_action :render_footers

  def dashboard
    @user = current_user
    @stories = @user.stories.order(:id)
  end
end
