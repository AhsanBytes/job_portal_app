import consumer from "channels/consumer"

const jobNotification = (jobId) => {
  consumer.subscriptions.create({ channel: "JobNotificationChannel", job_id: jobId }, {
    received(data) {
      console.log(data);
      const notificationElement = document.getElementById("notifications");
        if (notificationElement) {
          notificationElement.innerHTML += `<div class="notification">${data.message}</div>`;
        }
    }
  });
}

export { jobNotification };
