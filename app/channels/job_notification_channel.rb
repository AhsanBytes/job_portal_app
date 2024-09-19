class JobNotificationChannel < ApplicationCable::Channel
  def subscribed
    debugger
    stream_from "job_notification"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
# ActionCable.server.broadcast("job_notification_#{@job.id}", { message: "Real Time Notification, #{current_user.name} applied for your job: #{@job.title}"} )
