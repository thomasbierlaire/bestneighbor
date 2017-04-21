
class ExampleMailer < ActionMailer::Base
  default from: "contact@bestneighbor.fr"

  def dont_take_list(user, liste)
    @user = user
    @liste = liste
    mail(to: @user.email, subject: "Bestneighbor - vous ne prenez plus en charge une liste")
  end

  def no_list_taken(user, liste)
    @user = user
    @liste = liste
    mail(to: @user[0].email, subject: "Bestneighbor- votre liste n'est plus prise en charge")
  end

  def take_list(user, liste)
    @user = user
    @liste = liste
    mail(to: @user.email, subject: "Bestneighbor - vous prenez une liste en charge")
  end

  def list_taken(user, liste)
    @user = user
    @liste = liste
    mail(to: @user[0].email, subject: "Bestneighbor - votre liste est prise en charge")
  end

  def dont_take_trajet(user, trajet)
    @user = user
    @trajet = trajet
    mail(to: @user.email, subject: "Bestneighbor - vous ne prenez plus en charge un trajet")
  end

  def no_trajet_taken(user, trajet)
    @user = user
    @trajet = trajet
    mail(to: @user[0].email, subject: "Bestneighbor- votre trajet n'est plus pris en charge")
  end

  def take_trajet(user, trajet)
    @user = user
    @trajet = trajet
    mail(to: @user.email, subject: "Bestneighbor - vous prenez un trajet en charge")
  end

  def trajet_taken(user, trajet)
    @user = user
    @trajet = trajet
    mail(to: @user[0].email, subject: "Bestneighbor - votre trajet est pris en charge")
  end

end
