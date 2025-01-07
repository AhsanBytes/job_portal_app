class RootController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to jobs_path if current_user
  end
end
