class Slide < ApplicationRecord
  has_attachment :photo
  belongs_to :story

  validates :x_axis, uniqueness: { scope: [:y_axis, :story] }, presence: true
  validates :y_axis, presence: true
end
