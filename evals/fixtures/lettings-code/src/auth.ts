// Portal roles. Landlords and contractors never log in; they act through emailed links.
export type Role = "tenant" | "agent";

export function requireRole(user: { role: Role }, role: Role) {
  if (user.role !== role) throw new Error("forbidden");
}
