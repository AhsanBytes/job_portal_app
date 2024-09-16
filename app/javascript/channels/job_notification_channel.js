import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {

  consumer.subscriptions.create(
    { channel: "JobNotificationChannel", job_id: jobId },
    {
      connected() {},
      disconneted() {},
      received(data) {
        debugger
        alert(`New application received: ${data.message}`);
      }
    }
  )
});
