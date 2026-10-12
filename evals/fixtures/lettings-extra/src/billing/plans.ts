// Plans. Plus adds monthly landlord reports.
export const PLANS = { basic: [], plus: ["landlord_reports"] };
export function requirePlan(account, feature) {
  if (!PLANS[account.plan].includes(feature)) throw new Error("upgrade");
}
