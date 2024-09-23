class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @most_recent_user_job = @user.jobs.order(created_at: :desc).first
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to_jobs unless @user
  end
end
