class User < ApplicationRecord
  has_many :listes, dependent: :destroy
  has_many :trajets, dependent: :destroy
  has_many :covoiturages, dependent: :destroy

  validates :email, uniqueness: {message: "Email déjà utilisé"}, presence: {message: "Email à renseigner"}, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "Adresse email incorrecte" }
  validates :password, presence: {message: "Mot de passe à renseigner"}, length: { minimum: 6, too_short: "Minimum 6 caractères" }, confirmation: true
  validates_confirmation_of :password
  validates :password_confirmation, presence: true
  validates :code_postal, presence: {message: "Code postal à renseigner"}, format: { with: /\A[0-9][0-9][0-9][0-9][0-9]\z/, message: "Code postal sur 5 chiffres" }
  validates :notel, presence: {message: "N° de mobile à renseigner"}, format: { with: /\A0[67][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\z/, message: "N° de mobile incorrect (10 chiffres attendus)" }

  # Include default devise modules. Others available are:
  # :rememberable, :recoverable, :timeoutable and :omniauthable

  # ajouter :recoverable pour possibilité de mot de passe oublié

  #:validatable, :confirmable à supprimer pour tester

  devise :database_authenticatable, :trackable, :registerable, :lockable
end
