class UserMailer < ApplicationMailer

   default from: 'contact@bestneighbor.fr'

# Gestion des mails pour les listes de courses

   def dont_take_list_email(current, liste, user)

      @cemail = current.email
      @nom = liste.nom
      @uemail = user.email
      @url  = 'https://bestneighbor.fr/users/sign_in'

      mail(to: @cemail, subject: "Bestneighbor - vous ne prenez plus en charge une liste")

  end

  def no_list_taken_email(user, liste, current)

    @uemail = user.email
    @nom = liste.nom
    @cemail = current.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @uemail, subject: "Bestneighbor- votre liste n'est plus prise en charge")

  end

  def take_list_email(current, liste, user)

    @cemail = current.email
    @nom = liste.nom
    @uemail = user.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @cemail, subject: 'Bestneighbor - vous prenez une liste en charge')

  end

  def list_taken_email(user, liste, current)

    @uemail = user.email
    @nom = liste.nom
    @cemail = current.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @uemail, subject: 'Bestneighbor - votre liste est prise en charge')

  end

# Gestion des mails pour les trajets

  def dont_take_trajet_email(current, trajet, user)

      @cemail = current.email
      @nom = trajet.destination
      @uemail = user.email
      @url  = 'https://bestneighbor.fr/users/sign_in'

      mail(to: @cemail, subject: "Bestneighbor - vous ne prenez plus en charge un trajet")

  end

  def no_trajet_taken_email(user, trajet, current)

    @uemail = user.email
    @nom = trajet.destination
    @cemail = current.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @uemail, subject: "Bestneighbor- votre trajet n'est plus pris en charge")

  end

  def take_trajet_email(current, trajet, user)

    @cemail = current.email
    @nom = trajet.destination
    @uemail = user.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @cemail, subject: "Bestneighbor - vous prenez un trajet en charge")

  end

  def trajet_taken_email(user, trajet, current)

    @uemail = user.email
    @nom = trajet.destination
    @cemail = current.email
    @url  = 'https://bestneighbor.fr/users/sign_in'

    mail(to: @uemail, subject: "Bestneighbor - votre trajet est pris en charge")

  end

end
