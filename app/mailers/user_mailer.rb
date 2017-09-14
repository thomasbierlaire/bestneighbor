class UserMailer < ApplicationMailer

   default from: 'contact@bestneighbor.fr'

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

end
