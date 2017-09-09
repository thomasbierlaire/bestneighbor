module ListesHelper

########################"
# Gestion de l'envoi des mails
# Certainement "crad" ...

  def dont_take_list(current, liste, user)
      @current = current
      @liste = liste
      @user = user

      @cemail = @current.email
      @nom = @liste.nom
      @uemail = @user.email

      @body = 'Bonjour ' + @cemail + ', ' + 'vous ne prenez plus en charge la liste ' + @nom + ' de ' + @uemail

      email_sendgrid(@cemail, "Bestneighbor - vous ne prenez plus en charge une liste", @body)
  end

  def no_list_taken(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user.email
    @nom = @liste.nom
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + " n'est plus prise en charge" + ' par ' + @cemail

    email_sendgrid(@uemail, "Bestneighbor- votre liste n'est plus prise en charge", @body)
  end

  def take_list(current, liste, user)
    @current = current
    @liste = liste
    @user = user

    @cemail = @current.email
    @nom = @liste.nom
    @uemail = @user.email

    @body = 'Bonjour ' + @cemail + ', ' + 'vous avez pris en charge la liste ' + @nom + ' de ' + @uemail

    email_sendgrid(@cemail, "Bestneighbor - vous prenez une liste en charge", @body)
  end

  def list_taken(user, liste, current)
    @user = user
    @liste = liste
    @current = current

    @uemail = @user.email
    @nom = @liste.nom
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre liste ' + @nom + ' est prise en charge par ' + @cemail + ' !'

    email_sendgrid(@uemail, "Bestneighbor - votre liste est prise en charge", @body)
  end

end


