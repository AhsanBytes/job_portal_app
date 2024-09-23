class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_jobs

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_no, :resume])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :phone_no, :resume])
  end

  private
  
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def redirect_to_jobs
    flash[:alert] = "The page you were looking for doesn't exist."
    redirect_to jobs_path
  end
end
