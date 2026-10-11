// Emails the contractor the job: category, description, photos, access times.
export async function sendJob(repair, contractorId) {
  await mail.send(contractorEmail(contractorId), "New job", { repair });
}
