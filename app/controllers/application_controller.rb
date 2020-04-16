# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def login_required
    redirect_to new_user_session_path unless current_user
  end

  def follower_ids
    current_user.followers.pluck(:id) << current_user.id
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :profile, :icon])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :address, :profile, :icon])
    end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
