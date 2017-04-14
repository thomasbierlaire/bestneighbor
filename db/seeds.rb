# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Article.destroy_all
Liste.destroy_all
User.destroy_all

u1 = User.create!(email: "user1@hotmail.com", password: "passwd1")
u2 = User.create!(email: "user2@hotmail.com", password: "passwd2")
u3 = User.create!(email: "user3@hotmail.com", password: "passwd3")
u4 = User.create!(email: "user4@hotmail.com", password: "passwd4")
u5 = User.create!(email: "user5@hotmail.com", password: "passwd5")
u6 = User.create!(email: "user6@hotmail.com", password: "passwd6")

Liste.create!(user: u1, nom: "liste1user1", magasin: "Auchan", date_livraison: "20170425", takenby: "0")
Liste.create!(user: u2,nom: "liste1user2", magasin: "Auchan", date_livraison: "20170425",takenby: "0")
Liste.create!(user: u3,nom: "liste1user3", magasin: "Auchan", date_livraison: "20170425",takenby: "0")
Liste.create!(user: u4,nom: "liste4takenbyuser3", magasin: "Auchan", date_livraison: "20170425",takenby: u3.id)
Liste.create!(user: u5,nom: "liste5takenbyuser1", magasin: "Auchan", date_livraison: "20170425",takenby: u1.id)
Liste.create!(user: u6,nom: "liste6takenbyuser2", magasin: "Auchan", date_livraison: "20170425",takenby: u2.id)

@a1 = Liste.find_by_nom('liste1user1').id
@a2 = Liste.find_by_nom('liste1user2').id
@a3 = Liste.find_by_nom('liste1user3').id

Article.create!(nom: "article1l1u1", prix: "25.20", quantite: "2", liste_id: @a1)
Article.create!(nom: "article1l1u2", prix: "125.20", quantite: "12", liste_id: @a2)
Article.create!(nom: "article1l1u3", prix: "4.20", quantite: "2", liste_id: @a3)

