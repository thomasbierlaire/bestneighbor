class Trajet < ApplicationRecord
  belongs_to :user

  validates :destination, presence: {message: "Destination à renseigner"}
  validates :date, presence: {message: "Date à préciser"}
  validates :nbpass, presence: {message: "Nombre de passagers à renseigner"}
end
