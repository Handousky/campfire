class CategoriesController < ApplicationController
  before_action :render_footers
  skip_before_action :authenticate_user!

  def show
    @category = Category.find(params[:id])
    @stories = @category.stories.where(published: true)
    if user_signed_in?
      @stories.each do |story|
        Rating.create(story: story, user: current_user, score: 0) unless Rating.find_by(story: story, user: current_user)
      end
      @ratings = current_user.ratings.where(story: @stories)
    end
    @stories_popular = @stories.sort{ |a, b| b.avg_rating <=> a.avg_rating }
    @stories_recent = @stories.sort{ |a, b| a.updated_at <=> b.updated_at }
    @stories_alphabetic = @stories.sort{ |a, b| a.title <=> b.title }
  end
end
