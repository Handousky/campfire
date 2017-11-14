class StoryCategory < ApplicationRecord
  belongs_to :story
  belongs_to :category
end
