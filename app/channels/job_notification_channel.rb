class JobNotificationChannel < ApplicationCable::Channel
  def subscribed
    job = Job.find(params[:job_id])
    stream_from "job_notification_#{job.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
