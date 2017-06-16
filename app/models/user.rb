class User < ApplicationRecord
  has_many :listes, dependent: :destroy
  has_many :trajets, dependent: :destroy

  # Include default devise modules. Others available are:
  # :recoverable:timeoutable and :omniauthable

  # ajouter :recoverable pour possibilité de mot de passe oublié

  devise :database_authenticatable, :rememberable,
         :trackable, :validatable, :registerable, :lockable,
         :confirmable
end
