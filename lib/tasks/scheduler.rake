#Pour chaque liste dont la date de fin de validité est dépassée
#  Envoyer un mail au propriétaire de la liste pour l’informer de la suppression
#  Supprimer la liste
#Finpour


desc "This task is called by the Heroku scheduler add-on"
task :update_listes => :environment do
  puts "Updating listes..."

  @listes = Liste.find_by_sql("SELECT l.* FROM listes l WHERE
    l.date_livraison < '#{Time.now}'")

  @listes.each do |liste|
    puts "Nom : " + liste.nom + " - Date livraison : " + liste.date_livraison.to_s
    Liste.destroy(liste.id)
  end

  puts "done."
end

#Pour chaque trajet dont la date/heure de fin de validité est dépassée
#  Envoyer un mail au propriétaire du trajet pour l’informer de la suppression
#  Supprimer le trajet
#Finpour

desc "This task is called by the Heroku scheduler add-on"
task :update_trajets => :environment do
  puts "Updating trajets..."

  @trajets = Trajet.find_by_sql("SELECT t.* FROM trajets t WHERE
    t.date < '#{Time.now}'")

  @trajets.each do |trajet|
    puts "Nom : " + trajet.destination + " - Date : " + trajet.date.to_s + " - Heure : " + trajet.heure.to_s
    Trajet.destroy(trajet.id)
  end

  puts "done."
end
