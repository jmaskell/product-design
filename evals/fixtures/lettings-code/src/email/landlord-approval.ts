// Emails the landlord a quote with approve and decline links.
export async function sendApprovalRequest(repair, quoteGbp, opts: { reminder?: boolean } = {}) {
  const subject = opts.reminder ? "Reminder: repair approval needed" : "Repair approval needed";
  await mail.send(repair.landlordEmail, subject, { quoteGbp, link: `/approve/${repair.approvalToken}` });
}
