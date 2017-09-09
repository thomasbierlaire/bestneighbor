# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Liste.delete_all
Trajet.delete_all
User.delete_all

users = []
(0..20).each do |i|
  users << User.create!(email:"matos#{i}@test.fr", password: "password#{i}", code_postal: 67000)
end
(21..40).each do |i|
  users << User.create!(email:"matos#{i}@test.fr", password: "password#{i}", code_postal: 68000)
end

(0..20).each do |i|
  Liste.create!(nom: "liste #{i}" , content: "content #{i}", date_livraison: "20171001", user_id: users[i].id, takenby: users[i+10].id)
end
(21..40).each do |i|
  Liste.create!(nom: "liste #{i}" , content: "content #{i}", date_livraison: "20171001", user_id: users[i].id, takenby: 0)
end

(0..20).each do |i|
  Trajet.create!(destination: "destination #{i}" , nbpass: "#{i}", date: "20171001", user_id: users[i].id,  takenby: users[i+10].id)
end
(21..40).each do |i|
  Trajet.create!(destination: "destination #{i}" , nbpass: "#{i}", date: "20171001", user_id: users[i].id, takenby: 0)
end
