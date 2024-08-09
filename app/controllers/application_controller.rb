class ApplicationController < ActionController::Base
  # Ensure Devise methods are available in all controllers
  helper_method :current_user, :user_signed_in?

  # Skip authentication for public actions
  before_action :authenticate_user!, unless: :public_action?

  # Permit additional parameters for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def public_action?
    # Allow access to public pages like product details without sign-in
    controller_name.in?(%w[products home public]) # Adjust as needed
  end

  def configure_permitted_parameters
    # Permit new parameters for sign up and account update
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[address city postal_code province_id])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[address city postal_code province_id])
  end
end
