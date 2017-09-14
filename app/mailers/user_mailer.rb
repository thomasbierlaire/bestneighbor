class UserMailer < ApplicationMailer

   default from: 'contact@bestneighbor.fr'

   def dont_take_list_email(current, liste, user)
      @current = current
      @liste = liste
      @user = user

      @cemail = @current.email
      @nom = @liste.nom
      @uemail = @user.email

      #@body = 'Bonjour ' + @cemail + ', ' + 'vous ne prenez plus en charge la liste ' + @nom + ' de ' + @uemail

      #email_sendgrid(@cemail, "Bestneighbor - vous ne prenez plus en charge une liste", @body)

      @url  = 'https://bestneighbor.fr/users/sign_in'
      mail(to: @cemail, subject: "Bestneighbor - vous ne prenez plus en charge une liste")
  end

  def no_list_taken_email(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user.email
    @nom = @liste.nom
    @cemail = @current.email

    #@body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + " n'est plus prise en charge" + ' par ' + @cemail

    #email_sendgrid(@uemail, "Bestneighbor- votre liste n'est plus prise en charge", @body)

    @url  = 'https://bestneighbor.fr/users/sign_in'
    mail(to: @uemail, subject: "Bestneighbor- votre liste n'est plus prise en charge")
  end

  def take_list_email(current, liste, user)
    @current = current
    @liste = liste
    @user = user

    @cemail = @current.email
    @nom = @liste.nom
    @uemail = @user.email

    #@body = 'Bonjour ' + @cemail + ', ' + 'vous avez pris en charge la liste ' + @nom + ' de ' + @uemail

    #email_sendgrid(@cemail, "Bestneighbor - vous prenez une liste en charge", @body)

    #UserMailer.welcome_email(@current).deliver_later
    @url  = 'https://bestneighbor.fr/users/sign_in'
    mail(to: @cemail, subject: 'Bestneighbor - vous prenez une liste en charge')

  end

  def list_taken_email(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user.email
    @nom = @liste.nom
    @cemail = @current.email

    #@body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + ' est prise en charge par ' + @cemail + ' !'

    #email_sendgrid(@uemail, "Bestneighbor - votre liste est prise en charge", @body)

    @url  = 'https://bestneighbor.fr/users/sign_in'
    mail(to: @uemail, subject: 'Bestneighbor - votre liste est prise en charge')
  end

end
