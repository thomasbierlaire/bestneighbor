class User < ApplicationRecord
  has_many :listes
  validates :nom, presence: true
  validates :email, presence: true, uniqueness: true
  validates :passwd, presence: true
  validates :notel, presence: true
end
