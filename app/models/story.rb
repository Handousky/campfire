class Story < ApplicationRecord
  include PgSearch

  has_attachment :photo
  belongs_to :user
  has_many :story_categories, dependent: :destroy
  has_many :categories, through: :story_categories
  has_many :slides, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }
  validates :description, presence: true, length: { minimum: 40, maximum: 280 }

  PLACEHOLDER_IMAGE_PATHS = [
    "HorrorLogo_1.jpg",
    "HorrorLogo_2.jpg",
    "HorrorLogo_3.jpg",
    "HorrorLogo_4.jpg"
  ]

  def avg_rating
    self.ratings.empty? ? 0 : (self.ratings.map{ |r| r.score }.reduce(:+)) / self.ratings.length
  end

  def self.placeholder
    return PLACEHOLDER_IMAGE_PATHS.sample(1)[0]
  end

  pg_search_scope :global_search,
    against: [ [:title, 'A'], [:description, 'C'] ],
    associated_against: {
      user: [ [:nickname, 'B'] ]
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }
end
