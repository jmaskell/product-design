// GET /reports — monthly landlord report (Plus).
import { requirePlan } from "../billing/plans";
export async function get(req, db) {
  requirePlan(req.account, "landlord_reports");
  return db.repairs.monthlySummary(req.query.landlordId);
}
