# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Liste.destroy_all
Trajet.destroy_all
User.destroy_all

u1 = User.create!(email: "user1@hotmail.com", password: "passwd1", code_postal: "67720")
u2 = User.create!(email: "user2@hotmail.com", password: "passwd2", code_postal: "67720")
u3 = User.create!(email: "user3@hotmail.com", password: "passwd3", code_postal: "67720")
u4 = User.create!(email: "user4@hotmail.com", password: "passwd4", code_postal: "67720")
u5 = User.create!(email: "user5@hotmail.com", password: "passwd5", code_postal: "67720")
u6 = User.create!(email: "user6@hotmail.com", password: "passwd6", code_postal: "67720")
u7 = User.create!(email: "user7@hotmail.com", password: "passwd7", code_postal: "67750")
u8 = User.create!(email: "user8@hotmail.com", password: "passwd8", code_postal: "67750")
u9 = User.create!(email: "user9@hotmail.com", password: "passwd9", code_postal: "67720")
u10= User.create!(email: "user10@hotmail.com", password: "passwd10", code_postal: "67720")
u11 = User.create!(email: "user11@hotmail.com", password: "passwd11", code_postal: "67720")
u12 = User.create!(email: "user12@hotmail.com", password: "passwd12", code_postal: "67720")
u13 = User.create!(email: "user13@hotmail.com", password: "passwd13", code_postal: "67720")
u14 = User.create!(email: "user14@hotmail.com", password: "passwd14", code_postal: "67720")
u15 = User.create!(email: "user15@hotmail.com", password: "passwd15", code_postal: "67750")
u16 = User.create!(email: "user16@hotmail.com", password: "passwd16", code_postal: "67750")

Liste.create!(user: u1, nom: "liste1user1", content: "contenu à détailler", date_livraison: "20170601", takenby: "0")
Liste.create!(user: u2,nom: "liste1user2", content: "contenu à détailler", date_livraison: "20170603",takenby: "0")
Liste.create!(user: u3,nom: "liste1user3", content: "contenu à détailler", date_livraison: "20170602",takenby: "0")
Liste.create!(user: u4,nom: "liste4takenbyuser3", content: "contenu à détailler", date_livraison: "20170604",takenby: u3.id)
Liste.create!(user: u5,nom: "liste5takenbyuser1", content: "contenu à détailler", date_livraison: "20170605",takenby: u1.id)
Liste.create!(user: u6,nom: "liste6takenbyuser2", content: "contenu à détailler", date_livraison: "20170606",takenby: u2.id)
Liste.create!(user: u7, nom: "liste1user7", content: "contenu à détailler", date_livraison: "20170607", takenby: "0")
Liste.create!(user: u8,nom: "liste1user8", content: "contenu à détailler", date_livraison: "20170608",takenby: "0")
Liste.create!(user: u9, nom: "liste1user1", content: "contenu à détailler", date_livraison: "20170601", takenby: "0")
Liste.create!(user: u10,nom: "liste1user2", content: "contenu à détailler", date_livraison: "20170603",takenby: "0")
Liste.create!(user: u11,nom: "liste1user3", content: "contenu à détailler", date_livraison: "20170602",takenby: "0")

Trajet.create!(user: u1, destination: "destination1", nbpass: "1", date: "20170601", takenby: "0")
Trajet.create!(user: u2, destination: "destination2", nbpass: "2", date: "20170602", takenby: "0")
Trajet.create!(user: u3, destination: "destination3", nbpass: "3", date: "20170603", takenby: "0")
Trajet.create!(user: u4, destination: "destination4takenbyuser3", nbpass: "1", date: "20170604", takenby: u3.id)
Trajet.create!(user: u5, destination: "destination5takenbyuser1", nbpass: "2", date: "20170605", takenby: u1.id)
Trajet.create!(user: u6, destination: "destination6takenbyuser2", nbpass: "3", date: "20170606", takenby: u2.id)
Trajet.create!(user: u7, destination: "destination7", nbpass: "1", date: "20170607", takenby: "0")
Trajet.create!(user: u8, destination: "destination8", nbpass: "2", date: "20170608", takenby: "0")
Trajet.create!(user: u9, destination: "destination1", nbpass: "1", date: "20170601", takenby: "0")
Trajet.create!(user: u10, destination: "destination2", nbpass: "2", date: "20170602", takenby: "0")
Trajet.create!(user: u11, destination: "destination3", nbpass: "3", date: "20170603", takenby: "0")
