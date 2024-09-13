class PagesController < ApplicationController
  def home
    if current_user
      if current_user.admin?
        redirect_to jobs_path
      end
    end
  end
end
