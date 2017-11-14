class Story < ApplicationRecord
  belongs_to :user
  has_many :story_categories, dependent: :destroy
  has_many :categories, trough: :story_category

  validates :title, presence: true, uniqueness: true, length: { min: 3, max: 40 }
  validates :description, presence: true, length: { min: 40, max: 280 }
end
