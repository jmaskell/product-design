// Runs daily at 09:00. Re-sends the approval email when the landlord has not replied in 48 hours.
import { sendApprovalRequest } from "../email/landlord-approval";

export async function run(db) {
  const stale = await db.repairs.where({ status: "awaiting_approval" }).olderThan("48h");
  for (const r of stale) await sendApprovalRequest(r, r.quoteGbp, { reminder: true });
}
