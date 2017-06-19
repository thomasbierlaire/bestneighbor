class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:code_postal])
   end

   # Nécessaire pour la gestion des url des images
   # HOST doit être définie en production
   # heroku config:set HOST=www.my_product.com pour configurer Heroku
   # heroku config:get HOST pour vérifier si c'est OK
   def default_url_options
    { host: ENV['HOST'] || 'localhost:3000' }
   end

   def email_sendgrid (to, subject, body)

    dest = to.to_s
    sujet = subject.to_s
    corps = body.to_s

    require 'mail'

    Mail.defaults do
    delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                             :port      => 587,
                             :domain    => "bestneighbor.fr",
                             :user_name => ENV['SENDGRID_USERNAME'],
                             :password  => ENV['SENDGRID_PASSWORD'],
                             :authentication => 'plain',
                             :enable_starttls_auto => true }
    end

    mail = Mail.deliver do

      to "#{dest}"
      from 'contact@bestneighbor.fr'
      subject "#{sujet}"
      text_part do
        body "#{corps}"
      end

    end
  end
end
