class Liste < ApplicationRecord
  belongs_to :user

  validates :nom, presence: {message: "Nom de la liste à renseigner"}
  validates :content, presence: {message: "Contenu de la liste à renseigner"}
  validates :date_livraison, presence: {message: "Date de livraison à préciser"}

end
