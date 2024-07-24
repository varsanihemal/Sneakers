class ApplicationController < ActionController::Base
  # Ensure Devise methods are available in all controllers
  helper_method :current_user, :user_signed_in?

  # Skip authentication for public actions
  before_action :authenticate_user!, unless: :public_action?

  private

  def public_action?
    # Allow access to public pages like product details without sign-in
    controller_name.in?(%w(products home public)) # Adjust as needed
  end
end
