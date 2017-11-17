class Slide < ApplicationRecord
  has_attachment :photo
  belongs_to :story

  validates :x_axis, uniqueness: { scope: [:y_axis, :story] }, presence: true
  validates :y_axis, presence: true



  def get_left
    slide = Slide.find_by(x_axis: (self.x_axis - 1), y_axis: self.y_axis, story: self.story)
    return slide unless slide.nil? || self.block_access_from_left
  end

  def get_right
    slide = Slide.find_by(x_axis: (self.x_axis + 1), y_axis: self.y_axis, story: self.story)
    return slide unless slide.nil? || self.block_access_from_right
  end

  def get_down
    slide = Slide.find_by(x_axis: self.x_axis, y_axis: (self.y_axis - 1), story: self.story)
    return slide unless slide.nil? || self.block_access_from_down
  end

  def get_up
    slide = Slide.find_by(x_axis: self.x_axis, y_axis: (self.y_axis + 1), story: self.story)
    return slide unless slide.nil? || self.block_access_from_up
  end

  def toggle_block_left
    self.block_access_from_left = !self.block_access_from_left
    self.save!
  end

  def toggle_block_right
    self.block_access_from_right = !self.block_access_from_right
    self.save!
  end

  def toggle_block_up
    self.block_access_from_up = !self.block_access_from_up
    self.save!
  end

  def toggle_block_down
    self.block_access_from_down = !self.block_access_from_down
    self.save!
  end




end
