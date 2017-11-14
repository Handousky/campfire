class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @slides = Story.find(params[:story_id]).slides
  end

  def show
  end

  def new
    @slide = Slide.new
    @story = Story.find(params[:story_id])
  end

  def create
    @slide = Slide.new(slides_params)
    @slide.story = Story.find(params[:story_id])
    if @slide.save
      redirect_to slides_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @slide.update(slide_params)
      redirect_to slide_path(@slide)
    else
      render :new
    end
  end

  def destroy
    @story.destroy
    redirect_to slides_path
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def slides_params
    params.require(:slide).permit(:narration)
  end
end
