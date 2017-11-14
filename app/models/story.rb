class Story < ApplicationRecord
  belongs_to :user
  has_many :story_categories, dependent: :destroy
  has_many :categories, through: :story_category

  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }
  validates :description, presence: true, length: { minimum: 40, maximum: 280 }
end
