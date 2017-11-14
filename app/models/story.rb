class Story < ApplicationRecord
  belongs_to :user
  has_many :story_categories, dependent: :destroy
  has_many :categories, trough: :story_category
end
