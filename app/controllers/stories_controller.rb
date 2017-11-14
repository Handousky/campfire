class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    if @story.save
      params[:story][:categories].each do |category_id|
        unless category_id == "" || Category.find(category_id).nil?
          @tag = StoryCategory.new
          @tag.category = Category.find(category_id)
          @tag.story = @story
          @tag.save
        end
        byebug
      end
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :description, :categories)
  end
end
