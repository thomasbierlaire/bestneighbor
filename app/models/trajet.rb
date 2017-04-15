class Trajet < ApplicationRecord
  belongs_to :user

  validates :destination, presence: true
  validates :date, presence: true
  validates :heure, presence: true
  validates :nbpass, presence: true
end
