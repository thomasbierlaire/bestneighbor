class Liste < ApplicationRecord
  belongs_to :user

  validates :nom, presence: {message: "Nom de la liste à renseigner"}, length: { maximum: 40, too_long: "Maximum 40 caractères" }
  validates :content, presence: {message: "Contenu de la liste à renseigner"}
  validates :adresse_livraison, presence: {message: "Adresse de livraison à renseigner"}, length: { maximum: 40, too_long: "Maximum 40 caractères" }
  validates :date_livraison, presence: {message: "Date de livraison à renseigner"}
  validates :heure_livraison, presence: {message: "Heure de livraison à renseigner"}, format: { with: /\A([01]?[0-9]|2[0-3]):[0-5][0-9]\z/, message: "Heure à saisir au format HH:MM" }

  paginates_per 5

  #@listes_prises = Liste.where(takenby: current_user).order(:date_livraison)
  scope :taken_by, -> (utilisateur) { where("takenby = ? and date_livraison >= ?", utilisateur, Time.now.to_date.strftime("%Y%m%d").to_s).order(date_livraison: :asc) }
  #@listes_dispo = Liste.find_by_sql("SELECT l.* FROM listes l, users u WHERE
  #l.user_id = u.id AND l.user_id <> '#{current_user.id}' AND l.takenby = 0 AND
  #u.code_postal='#{current_user.code_postal}' AND l.date_livraison >= '#{@jour}'
  #order by l.date_livraison")
  #cope :not_taken, -> (utilisateur) { wh"user_id != ? AND takenby = ? AND date_livraison >= ?", utilisateur, 0, Time.now) }
  scope :not_taken, -> (utilisateur, code_postal) { joins(:user).where("user_id != ? and takenby = ? AND date_livraison >= ? AND users.code_postal = ?", utilisateur, 0, Time.now.to_date.strftime("%Y%m%d").to_s, code_postal).order(date_livraison: :asc) }
  scope :my_listes, -> (utilisateur) { where("user_id = ? and date_livraison >= ?", utilisateur, Time.now.to_date.strftime("%Y%m%d").to_s).order(date_livraison: :asc) }

end
