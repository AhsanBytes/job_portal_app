class RootController < ApplicationController
  def index
    if current_user
      redirect_to jobs_path
    end
  end
end
