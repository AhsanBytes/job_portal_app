class JobMailer < ApplicationMailer

  def application_confirmation(user, job)
    @user = user
    @job = job
    mail(to: @user.email, subject: 'Job Application Confirmation')
  end
end
