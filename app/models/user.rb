class User < ApplicationRecord
  has_many :demandeurs
  has_many :fournisseurs
  validates :email, presence: true, uniqueness: true
end
