class User < ApplicationRecord
  has_many :listes
  has_many :trajets

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # ajouter :registerable pour possibilité de création de user
  # ajouter :recoverable pour possibilité de mot de passe oublié

  devise :database_authenticatable, :rememberable,
         :trackable, :validatable, :registerable, :recoverable
end
