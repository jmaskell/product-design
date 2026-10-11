// GET /contractor-ratings — tenants' ratings of contractors.
export async function get(req, db) {
  return db.ratings.byContractor();
}
