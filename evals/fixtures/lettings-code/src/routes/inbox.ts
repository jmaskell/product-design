// GET /inbox — the agent's repairs, urgent first.
import { requireRole } from "../auth";

export async function get(req, db) {
  requireRole(req.user, "agent");
  return db.repairs.where({ status: ["reported", "awaiting_approval", "approved", "booked"] }).orderBy("urgent", "desc");
}
