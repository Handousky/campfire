class StoryCategory < ApplicationRecord
  belongs_to :story
  belongs_to :category

  validates :story, uniqueness: { scope: :category }
end
