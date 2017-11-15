class Slide < ApplicationRecord
  belongs_to :story

  validates :x_axis, uniqueness: { scope: :y_axis }, presence: true
  validates :y_axis, presence: true
end
