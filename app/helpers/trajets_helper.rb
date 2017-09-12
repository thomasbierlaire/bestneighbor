module TrajetsHelper

  ########################"
# Gestion de l'envoi des mails
# Certainement "crad" ...
  def dont_take_trajet(current, trajet, user)
      @current = current
      @trajet = trajet
      @user = user

      @cemail = @current.email
      @nom = @trajet.destination
      @uemail = @user.email

      @body = 'Bonjour ' + @cemail + ', ' + 'vous ne prenez plus en charge le trajet ' + @nom + ' de ' + @uemail

      email_sendgrid(@cemail, "Bestneighbor - vous ne prenez plus en charge un trajet", @body)
  end

  def no_trajet_taken(user, trajet, current)
    @user = user
    @trajet = trajet
    @current = current

    @uemail = @user.email
    @nom = @trajet.destination
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre trajet ' + @nom + " n'est plus pris en charge" + ' par ' + @cemail

    email_sendgrid(@uemail, "Bestneighbor- votre trajet n'est plus pris en charge", @body)
  end

  def take_trajet(current, trajet, user)
    @current = current
    @trajet = trajet
    @user = user

    @cemail = @current.email
    @nom = @trajet.destination
    @uemail = @user.email

    @body = 'Bonjour ' + @cemail + ', ' + 'vous avez pris en charge le trajet ' + @nom + ' de ' + @uemail

    email_sendgrid(@cemail, "Bestneighbor - vous prenez un trajet en charge", @body)
  end

  def trajet_taken(user, trajet, current)
    @user = user
    @trajet = trajet
    @current = current

    @uemail = @user.email
    @nom = @trajet.destination
    @cemail = @current.email

    @body = 'Bonjour ' + @uemail + ', ' + 'votre trajet ' + @nom + ' est pris en charge par ' + @cemail + ' !'

    email_sendgrid(@uemail, "Bestneighbor - votre trajet est pris en charge", @body)
  end


end
