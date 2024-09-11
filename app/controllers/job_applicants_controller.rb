class JobApplicantsController < ApplicationController
  before_action :authenticate_user!

  def create
    @job_applicant = JobApplicant.new(job_applicant_params)
    if @job_applicant.save
      JobMailer.application_received(@job_applicant).deliver_later
      redirect_to @job_applicant.job, notice: 'Your application was successfully submitted.'
    else
      render :new
    end
  end

  private

  def job_applicant_params
    params.require(:job_applicant).permit(:job_id, :name, :email, :phone_no, :resume)
  end
end
