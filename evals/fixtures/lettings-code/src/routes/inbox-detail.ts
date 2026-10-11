// POST /inbox/:id — the agent triages one repair.
// Landlord approval is needed for spend above £250.
import { requireRole } from "../auth";
import { APPROVAL_THRESHOLD_GBP } from "../rules";
import { sendApprovalRequest } from "../email/landlord-approval";
import { sendJob } from "../email/contractor-job";

export async function post(req, db) {
  requireRole(req.user, "agent");
  const repair = await db.repairs.find(req.params.id);
  const { priority, quoteGbp, contractorId } = req.body;
  await db.repairs.update(repair.id, { priority, quoteGbp, contractorId });
  if (quoteGbp > APPROVAL_THRESHOLD_GBP) {
    await sendApprovalRequest(repair, quoteGbp);
    return db.repairs.update(repair.id, { status: "awaiting_approval" });
  }
  await sendJob(repair, contractorId);
  return db.repairs.update(repair.id, { status: "booked" });
}
