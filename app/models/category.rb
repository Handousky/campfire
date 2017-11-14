class Category < ApplicationRecord
  has_many :story_categories, dependent: :destroy
  has_many :stories, trough: :story_category
end
