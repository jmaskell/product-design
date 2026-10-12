// GET /repairs — the tenant's repairs and their status.
import { requireRole } from "../auth";

export async function get(req, db) {
  requireRole(req.user, "tenant");
  return db.repairs.where({ tenantId: req.user.id }).select("category", "status", "updatedAt");
}
