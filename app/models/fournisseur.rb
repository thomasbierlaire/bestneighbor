class Fournisseur < ApplicationRecord
  belongs_to :user
  has_many :liste_fournisseurs
end
