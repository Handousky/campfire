class User < ApplicationRecord
  has_attachment :photo
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stories, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :bio, length: { maximum: 512 }
end
