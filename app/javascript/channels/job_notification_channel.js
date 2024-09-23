import consumer from "./consumer"

  consumer.subscriptions.create(
    { channel: "JobNotificationChannel" },
    {
      connected() {
        console.log("Connected")
      },
      disconneted() {},
      received(data) {
        alert(`New application received: ${data.message}`);
      }
    }
  )

