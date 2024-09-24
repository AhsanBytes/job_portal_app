import consumer from "./consumer"

consumer.subscriptions.create(
  { channel: "JobNotificationChannel" },
  {
    connected() {
      console.log("Connected to JobNotificationChannel");
    },
    disconnected() {
      console.log("Disconnected from JobNotificationChannel");
    },
    received(data) {
      if (!document.querySelector(".flash-notice")) {
        let flashMessage = document.createElement("div");
        flashMessage.className = "flash-notice";
        flashMessage.innerHTML = `New application received: ${data.message}`;

        document.body.appendChild(flashMessage);
        console.log(flashMessage)

        setTimeout(() => {
          window.location.reload();
        }, 1000);
      }
    } 
  }
)
