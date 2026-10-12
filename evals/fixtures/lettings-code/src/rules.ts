// Repair spend above this needs the landlord's approval.
export const APPROVAL_THRESHOLD_GBP = 500;

// Safety repairs must start within 24 hours (legal duty).
export const URGENT_CATEGORIES = ["gas", "water", "electrics"] as const;
export const URGENT_START_HOURS = 24;
