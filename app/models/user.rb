class User < ApplicationRecord
  has_many :listes

  validates :email, presence: true, uniqueness: true
  validates :passwd, presence: true
  validates :notel, presence: true, uniqueness: true

end
