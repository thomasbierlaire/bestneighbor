
class ExampleMailer < ActionMailer::Base
  default from: "contact@bestneighbor.fr"

    def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Test MATOS - it work !!')
  end

end
