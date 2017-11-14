class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stories, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true, length: { max: 20 }
  validates :email, presence: true, uniqueness: true
  validates :bio, length: { max: 512 }
end
