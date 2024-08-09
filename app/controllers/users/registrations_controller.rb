# app/controllers/users/registrations_controller.rb
module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[address city postal_code province_id])
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[address city postal_code province_id])
    end
  end
end
