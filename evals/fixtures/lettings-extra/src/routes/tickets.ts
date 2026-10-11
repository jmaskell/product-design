// GET /tickets — the agent's open tickets, oldest first.
import { requireRole } from "../auth";
export async function get(req, db) {
  requireRole(req.user, "agent");
  return db.repairs.where({ status: ["reported", "booked"] }).orderBy("createdAt");
}
