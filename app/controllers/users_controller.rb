class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @most_recent_user_job = @user.jobs.find_by(id: params[:job_id])

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to jobs_path unless @user
  end
end
