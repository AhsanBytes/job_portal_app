class JobNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "job_creator_#{params[:creator_id]}"
  end
end
