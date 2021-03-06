class SlidesController < ApplicationController
  before_action :set_slide, only: [:show, :edit, :update, :destroy, :block_up, :block_down, :block_left, :block_right]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @story = Story.find(params[:story_id])
    @slides = @story.slides
    @slides = @slides.sort { |a, b| [a.x_axis, a.y_axis] <=> [b.x_axis, b.y_axis] }
    @width = @slides.map { |slide| slide.x_axis }.minmax.reduce(:-).abs+1
    @height = @slides.map { |slide| slide.y_axis }.minmax.reduce(:-).abs+1
    @min_width = @slides.map { |slide| slide.x_axis }.min
    @max_width = @slides.map { |slide| slide.x_axis }.max
    @min_height = @slides.map { |slide| slide.y_axis }.min
    @max_height = @slides.map { |slide| slide.y_axis }.max
    @first_slide = @story.slides.find_by(x_axis: 0, y_axis: 0)
  end

  def show
    respond_to do |format|
      format.js
      format.html
    end
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
    if @slide.update(slides_params)
      # byebug
      # @slide.photo = slides_params[:photo]
      # photo.save!
      set_adjacents(@slide)
      respond_to do |format|
        format.html { render :edit }
        format.js  # <-- will render `app/views/reviews/update.js.erb`
      end
    else
      set_adjacents(@slide)
      respond_to do |format|
        format.html { render :edit }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @slide.destroy
    redirect_to story_slides_path(@slide.story)
  end

  def block_up
    @slide.toggle_block_up
    redirect_to :back
  end

  def block_down
    @slide.toggle_block_down
    redirect_to :back
  end

  def block_left
    @slide.toggle_block_left
    redirect_to :back
  end

  def block_right
    @slide.toggle_block_right
    redirect_to :back
  end

  private

  def set_slide
    @slide = Slide.find(params[:id])
    @story = Story.find(params[:story_id])
    @first_slide = @story.slides.find_by(x_axis: 0, y_axis: 0)
  end

  def set_adjacents(slide)
    @up_slide = Slide.find_by(x_axis: slide.x_axis, y_axis: (slide.y_axis + 1), story: @story) || nil
    @down_slide = Slide.find_by(x_axis: slide.x_axis, y_axis: (slide.y_axis - 1), story: @story) || nil
    @left_slide = Slide.find_by(x_axis: (slide.x_axis - 1), y_axis: slide.y_axis, story: @story) || nil
    @right_slide = Slide.find_by(x_axis: (slide.x_axis + 1), y_axis: slide.y_axis, story: @story) || nil
  end

  def slides_params
    params[:slide][:photo] = nil if params[:slide][:photo] = ""
    params.require(:slide).permit(:narration, :photo, :json, :name, :sound)
  end

  def slides_coords
    params.require(:slide).permit(:x_axis, :y_axis, :name)
  end
end
