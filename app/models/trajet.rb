class Trajet < ApplicationRecord
  belongs_to :user

  validates :destination, presence: {message: "Destination à renseigner"}
  validates :date, presence: {message: "Date à préciser"}
  validates :nbpass, presence: {message: "Nombre de passagers à renseigner"}

  paginates_per 5

  #@trajets_pris = Trajet.where(takenby: current_user).order(:date)
  scope :taken_by, -> (utilisateur) { where("takenby = ?", utilisateur).order(date: :asc) }
  #@trajets_dispo = Trajet.find_by_sql("SELECT t.* FROM trajets t, users u WHERE
  #    t.user_id = u.id AND t.user_id <> '#{current_user.id}' AND t.takenby = 0 AND
  #    u.code_postal='#{current_user.code_postal}' AND t.date >= '#{@jour}'
  #    order by t.date")
  scope :not_taken, -> (utilisateur, code_postal) { joins(:user).where("user_id != ? and takenby = ? AND date >= ? AND users.code_postal = ?", utilisateur, 0, Time.now, code_postal).order(date: :asc) }

end
