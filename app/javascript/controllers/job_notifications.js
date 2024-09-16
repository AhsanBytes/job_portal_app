import { jobNotification } from "../channels/job_notification_channel"

document.addEventListener("turbo:load", () => {
  const jobIdElement = document.getElementById("job-id");
  if (jobIdElement) {
    const jobId = jobIdElement.value;
    if (jobId) {
      jobNotification(jobId);
    }
  }
});
