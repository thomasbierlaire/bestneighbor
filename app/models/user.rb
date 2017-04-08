class User < ApplicationRecord
  has_one :liste

  validates :email, presence: true, uniqueness: true
  validates :passwd, presence: true
  validates :notel, presence: true, uniqueness: true

end
