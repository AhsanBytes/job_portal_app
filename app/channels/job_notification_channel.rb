class JobNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_notification_#{params[:job_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
