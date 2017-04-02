class Article < ApplicationRecord
  belongs_to :liste

  validates :nom, presence: true
  validates :prix, presence: true
  validates :quantite, presence: true

end
