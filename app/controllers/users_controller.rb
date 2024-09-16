class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]
  after_action :verify_authorized

  def show
    authorize @user

    @most_recent_job = @user.user_jobs.order(created_at: :desc).first
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
