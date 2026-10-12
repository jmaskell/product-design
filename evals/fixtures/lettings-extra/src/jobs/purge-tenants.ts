// Runs monthly. Deletes tenant records 10 years after the tenancy ends.
export async function run(db) {
  await db.tenants.where({ tenancyEndedAt: { olderThan: "10y" } }).delete();
}
