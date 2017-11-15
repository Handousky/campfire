class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  def index
    @story = Story.find(params[:story_id])
    @slides = @story.slides
  end

  def show
    @story = Story.find(params[:story_id])
    @up_slide = Slide.find_by(x_axis: @slide.x_axis, y_axis: (@slide.y_axis - 1), story: @story) || nil
    @down_slide = Slide.find_by(x_axis: @slide.x_axis, y_axis: (@slide.y_axis + 1), story: @story) || nil
    @left_slide = Slide.find_by(x_axis: (@slide.x_axis - 1), y_axis: @slide.y_axis, story: @story) || nil
    @right_slide = Slide.find_by(x_axis: (@slide.x_axis + 1), y_axis: @slide.y_axis, story: @story) || nil

  end

  def new
    @slide = Slide.new
    @story = Story.find(params[:story_id])
  end

  def create
    @slide = Slide.new(slides_params)
    @slide.story = Story.find(params[:story_id])
    if @slide.save
      redirect_to story_slides_path(@slide.story)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @slide.update(slides_params)
      redirect_to story_slide_path(@slide.story, @slide)
    else
      render :edit
    end
  end

  def destroy
    @slide.destroy
    redirect_to story_slides_path(@slide.story)
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
  end

  def slides_params
    params.require(:slide).permit(:narration, :x_axis, :y_axis, :photo)
  end
end
