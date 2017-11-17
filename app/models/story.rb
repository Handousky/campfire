class Story < ApplicationRecord
  has_attachment :photo
  belongs_to :user
  has_many :story_categories, dependent: :destroy
  has_many :categories, through: :story_categories
  has_many :slides, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }
  validates :description, presence: true, length: { minimum: 40, maximum: 280 }

  def avg_rating
    return self.ratings.map{ |r| r.score }.reduce(:+) unless self.ratings.empty?
    return 0
  end
end
