
class ExampleMailer < ActionMailer::Base
  default from: "contact@bestneighbor.fr"

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Test MATOS - it work !!')
  end

  def dont_take_list(user, liste)
    @user = user
    @liste = liste
    mail(to: @user.email, subject: "Bestneighbor : vous ne prenez plus en charge une liste")
  end

  def no_list_taken(user, liste)
    @user = user
    @liste = liste
    mail(to: @user.email, subject: "Bestneighbor : votre liste n'est plus prise en charge")
  end

end
