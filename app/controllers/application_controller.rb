class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_any!, except:[:top,:news,:game,:new_guest]

  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end
  end


  def after_sign_in_path_for(resource)
    case resource
    when Admin
      root_path
    when User
      user_path(current_user)
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number])
    end
end
