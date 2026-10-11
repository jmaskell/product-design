// Tables. Personal data: tenants and landlords.
export const tenants = { id: "uuid", fullName: "text", email: "text", phone: "text", dateOfBirth: "date", tenancyEndedAt: "date?" };
export const landlords = { id: "uuid", name: "text", email: "text", bankAccount: "text" };
export const repairs = { id: "uuid", tenantId: "uuid", category: "text", description: "text", photos: "text[]", status: "text" };
