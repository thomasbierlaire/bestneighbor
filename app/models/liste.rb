class Liste < ApplicationRecord
  belongs_to :user

  validates :nom, presence: {message: "Nom de la liste à renseigner"}
  validates :content, presence: {message: "Contenu de la liste à renseigner"}
  validates :date_livraison, presence: {message: "Date de livraison à préciser"}

  paginates_per 5

  #@listes_prises = Liste.where(takenby: current_user).order(:date_livraison)
  scope :taken_by, -> (utilisateur) { where("takenby = ?", utilisateur).order(date_livraison: :asc) }
  #@listes_dispo = Liste.find_by_sql("SELECT l.* FROM listes l, users u WHERE
  #l.user_id = u.id AND l.user_id <> '#{current_user.id}' AND l.takenby = 0 AND
  #u.code_postal='#{current_user.code_postal}' AND l.date_livraison >= '#{@jour}'
  #order by l.date_livraison")
  #cope :not_taken, -> (utilisateur) { wh"user_id != ? AND takenby = ? AND date_livraison >= ?", utilisateur, 0, Time.now) }
  scope :not_taken, -> (utilisateur, code_postal) { joins(:user).where("user_id != ? and takenby = ? AND date_livraison >= ? AND users.code_postal = ?", utilisateur, 0, Time.now, code_postal).order(date_livraison: :asc) }

end
