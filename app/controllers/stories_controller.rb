class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
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

  def create_tags(story)
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
