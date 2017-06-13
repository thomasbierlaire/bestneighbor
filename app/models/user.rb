class User < ApplicationRecord
  has_many :listes
  has_many :trajets

  # Include default devise modules. Others available are:
  # :recoverable:timeoutable and :omniauthable

  # ajouter :recoverable pour possibilité de mot de passe oublié

  devise :database_authenticatable, :rememberable,
         :trackable, :validatable, :registerable, :lockable,
         :confirmable
end
