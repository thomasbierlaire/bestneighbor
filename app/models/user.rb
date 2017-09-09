class User < ApplicationRecord
  has_many :listes, dependent: :destroy
  has_many :trajets, dependent: :destroy

  # Include default devise modules. Others available are:
  # :rememberable, :recoverable, :timeoutable and :omniauthable

  # ajouter :recoverable pour possibilité de mot de passe oublié

  #:validatable, :confirmable à supprimer pour tester

  devise :database_authenticatable, :trackable, :registerable, :lockable,
  :validatable, :confirmable
end
