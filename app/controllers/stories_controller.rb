class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy, :publish]
  before_action :render_footers
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    if params[:query]
      @stories = Story.global_search(params[:query])
    else
      @stories = Story.all
      @stories = @stories.sort{ |a, b| b.avg_rating <=> a.avg_rating }
    end
    if user_signed_in?
      @stories.each do |story|
        Rating.create(story: story, user: current_user, score: 0) unless Rating.find_by(story: story, user: current_user)
      end
      @ratings = current_user.ratings.where(story: @stories)
    end
  end

  def show
    @story = Story.find(params[:id])
    @first_slide = @story.slides.find_by(x_axis: 0, y_axis: 0)
  end

  def edit
    @categories = @story.categories
  end

  def update
    if @story.update(story_params)
      update_tags(@story)
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def new
    @story = Story.new
    @categories = []
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      create_tags(@story)
      if Slide.create(x_axis: 0, y_axis: 0, story: @story)
        @slide = Slide.find_by(x_axis: 0, y_axis: 0, story: @story)
        redirect_to edit_story_slide_path(@story, @slide)
      else
        render :new, alert: "Something went wrong while creating the first slide..."
      end
    else
      render :new
    end
  end

  def destroy
    @story.destroy
    redirect_to :back
  end

  def publish
    @story.update(published: @story.published ? false : true)
    redirect_to :back, notice: @story.published ? 'Your Story was published!' : 'Your Story is now private'
  end

  private

  def create_tags(story)
    return if params[:story][:categories].nil?
    params[:story][:categories].each do |category_id|
      unless category_id == "" || Category.find(category_id).nil? || StoryCategory.find_by(story: story, category: Category.find(category_id))
        @tag = StoryCategory.new
        @tag.category = Category.find(category_id)
        @tag.story = story
        @tag.save
      end
    end
  end

  def update_tags(story)
    @categories = story.categories
    @categories.each do |category|
      unless params[:story][:categories].include?(category.id.to_s)
        @tag = StoryCategory.find_by(story: story, category: category)
        @tag.destroy
      end
    end

    create_tags(story)
  end

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :description, :categories, :photo)
  end
end
