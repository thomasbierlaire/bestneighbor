class Liste < ApplicationRecord
  belongs_to :user

  validates :nom, presence: true
  validates :date_livraison, presence: true

end
