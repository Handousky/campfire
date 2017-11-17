class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy]
  before_action :render_footers, only: [:index]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @story = Story.find(params[:story_id])
    @slides = @story.slides
    @first_slide = @story.slides.first
  end

  def show
    set_adjacents(@slide)
  end

  def create
    @slide = Slide.new(slides_coords)
    @slide.story = Story.find(params[:story_id])
    @slide.save
    set_adjacents(@slide)
    redirect_to edit_story_slide_path(@slide.story, @slide)
  end

  def edit
    set_adjacents(@slide)
  end

  def update
    @slide.update(slides_params)
    set_adjacents(@slide)
    render :edit
  end

  def destroy
    @slide.destroy
    redirect_to story_slides_path(@slide.story)
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
    @story = Story.find(params[:story_id])
    @first_slide = @story.slides.first
  end

  def set_adjacents(slide)
    @up_slide = Slide.find_by(x_axis: slide.x_axis, y_axis: (slide.y_axis + 1), story: @story) || nil
    @down_slide = Slide.find_by(x_axis: slide.x_axis, y_axis: (slide.y_axis - 1), story: @story) || nil
    @left_slide = Slide.find_by(x_axis: (slide.x_axis - 1), y_axis: slide.y_axis, story: @story) || nil
    @right_slide = Slide.find_by(x_axis: (slide.x_axis + 1), y_axis: slide.y_axis, story: @story) || nil
  end

  def slides_params
    params.require(:slide).permit(:narration, :photo, :json)
  end

  def slides_coords
    params.require(:slide).permit(:x_axis, :y_axis)
  end
end
