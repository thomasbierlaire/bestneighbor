class Liste < ApplicationRecord
  belongs_to :user
  has_many :articles

  validates :nom, presence: true

end
