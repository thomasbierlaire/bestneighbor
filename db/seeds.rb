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

User.create!(nom: "nom1", prenom: "prenom1", email: "email1", notel: "0101010101", passwd: "passwd1")
User.create!(nom: "nom2", prenom: "prenom2", email: "email2", notel: "0101010102", passwd: "passwd2")
User.create!(nom: "nom3", prenom: "prenom3", email: "email3", notel: "0101010103", passwd: "passwd3")

@l1 = User.find_by_email('email1').id
@l2 = User.find_by_email('email2').id
@l3 = User.find_by_email('email3').id

Liste.create!(nom: "liste1user1", takenby: "nil", user_id: @l1)
Liste.create!(nom: "liste1user2", takenby: "nil", user_id: @l2)
Liste.create!(nom: "liste1user3", takenby: "nil", user_id: @l3)

@a1 = Liste.find_by_nom('liste1user1').id
@a2 = Liste.find_by_nom('liste1user2').id
@a3 = Liste.find_by_nom('liste1user3').id

Article.create!(nom: "article1l1u1", prix: "25.20", quantite: "2", liste_id: @a1)
Article.create!(nom: "article1l1u2", prix: "125.20", quantite: "12", liste_id: @a2)
Article.create!(nom: "article1l1u3", prix: "4.20", quantite: "2", liste_id: @a3)

