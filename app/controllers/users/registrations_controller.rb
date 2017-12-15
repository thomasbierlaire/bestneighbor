class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  include SmsManagement

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super

    if resource.persisted?
      @neighborsToGet = User.where(code_postal: resource.code_postal)
      @nbNeighbors = @neighborsToGet.length

      ######################################################################
      # Envoi SMS à tous les utilisateurs ayant le même code postal tant que
      # le nb total de voisins est < 10
      if @nbNeighbors < 10
        @neighborsToGet.each do |neighbor|
          if neighbor != current_user
            @phonenumber = format_tel(neighbor.notel)
            @message = "Bestneighbor - Un nouveau voisin vient de s'inscrire : vous êtes désormais #{@nbNeighbors} voisins !"
            send_sms(@phonenumber, @message)
          end
        end
      end
      ######################################################################
    end

  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

end
