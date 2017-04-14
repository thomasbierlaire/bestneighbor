class User < ApplicationRecord
  has_one :liste

  validates :email, presence: true, format: { with: /\A.+@.+$\Z/ }, uniqueness: true
  validates :passwd, presence: true
  validates :notel, presence: true, uniqueness: true
  validates :nom, presence: true
  validates :codepostal, presence: true
  validates :ville, presence: true
end
