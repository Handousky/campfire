class Slide < ApplicationRecord
  belongs_to :story

  validates :x_axis, uniqueness: { scope: :y_axis }
end
