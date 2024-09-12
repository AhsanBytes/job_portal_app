class PagesController < ApplicationController
  def home
    @jobs = policy_scope(Job)
  end
end
