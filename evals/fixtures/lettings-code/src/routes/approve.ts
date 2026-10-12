// GET /approve/:token — the landlord approves or declines the spend from the email link.
import { sendJob } from "../email/contractor-job";

export async function get(req, db) {
  const repair = await db.repairs.findByApprovalToken(req.params.token);
  if (req.query.decision === "decline") {
    return db.repairs.update(repair.id, { status: "declined" });
  }
  await sendJob(repair, repair.contractorId);
  return db.repairs.update(repair.id, { status: "booked" });
}
