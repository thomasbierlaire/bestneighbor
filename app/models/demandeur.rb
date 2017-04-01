class Demandeur < ApplicationRecord
    belongs_to :user
    has_many :liste_demandeurs
end
