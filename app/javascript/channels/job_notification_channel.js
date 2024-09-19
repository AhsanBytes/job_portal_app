import consumer from "./consumer"

// document.addEventListener("turbolinks:load", () => {

  consumer.subscriptions.create(
    { channel: "JobNotificationChannel" },
    {
      connected() {
        console.log("Connected")
      },
      disconneted() {},
      received(data) {
        debugger
        alert(`New application received: ${data.message}`);
      }
    }
  )
// });
