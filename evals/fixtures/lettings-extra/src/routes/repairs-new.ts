// POST /repairs/new — the tenant reports a repair.
import { requireRole } from "../auth";
import { track } from "../analytics";
import { URGENT_CATEGORIES } from "../rules";

export async function post(req, db) {
  requireRole(req.user, "tenant");
  const { category, description, photos, accessTimes } = req.body;
  if (!category || !description) {
    return { status: 400, error: "Choose a category and describe the problem." };
  }
  const urgent = URGENT_CATEGORIES.includes(category);
  await db.repairs.insert({ tenantId: req.user.id, category, description, photos, accessTimes, urgent, status: "reported" });
  track("repair_reported", { category });
  return { redirect: "/repairs" };
}
