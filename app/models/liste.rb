class Liste < ApplicationRecord
  belongs_to :user
  has_many :articles

  validates :nom, presence: true
  validates :magasin, presence: true
  validates :date_livraison, presence: true

end
