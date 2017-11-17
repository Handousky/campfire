class Slide < ApplicationRecord
  has_attachment :photo
  belongs_to :story

  validates :x_axis, uniqueness: { scope: [:y_axis, :story] }, presence: true
  validates :y_axis, presence: true

  def get_left
    slide = Slide.find_by(x_axis: (self.x_axis - 1), y_axis: self.y_axis, story: @story)
    unless slide.block_access_from_right || slide.nil? return slide
  end

  def get_right
    slide = Slide.find_by(x_axis: (self.x_axis + 1), y_axis: self.y_axis, story: @story)
    unless slide.block_access_from_left || slide.nil? return slide
  end

  def get_down
    slide = Slide.find_by(x_axis: self.x_axis, y_axis: (self.y_axis - 1), story: @story)
    unless slide.block_access_from_up || slide.nil? return slide
  end

  def get_up
    slide = Slide.find_by(x_axis: self.x_axis, y_axis: (self.y_axis + 1), story: @story)
    unless slide.block_access_from_down || slide.nil? return slide
  end

  def block_left
    slide = self.get_left
    slide.block_access_from_right = true
    slide.save!
  end

  def block_right
    slide = self.get_right
    slide.block_access_from_left = true
    slide.save!
  end

  def block_up
    slide = self.get_up
    slide.block_access_from_down = true
    slide.save!
  end

  def block_down
    slide = self.get_down
    slide.block_access_from_up = true
    slide.save!
  end
end
