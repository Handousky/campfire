class UserController < ApplicationController
  before_action :render_footers
  skip_before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @stories = @user.stories.where(published: true)
    if user_signed_in?
      @stories.each do |story|
        Rating.create(story: story, user: current_user, score: 0) unless Rating.find_by(story: story, user: current_user)
      end
      @ratings = current_user.ratings.where(story: @stories)
    end
    @stories_popular = @stories.sort{ |a, b| b.avg_rating <=> a.avg_rating }.first(20)
    @stories_recent = @stories.sort{ |a, b| a.updated_at <=> b.updated_at }.first(20)
    @stories_alphabetic = @stories.sort{ |a, b| a.title <=> b.title }
  end

  def dashboard
    @user = current_user
    @stories = @user.stories.order(:id)
  end
end
