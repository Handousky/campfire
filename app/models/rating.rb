class Rating < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :score, inclusion: { in: 0..5 }
  validates :story, uniqueness: { scope: :user }
end
