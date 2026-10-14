// Sent to the contractor when a landlord approves the work.
export function contractorVisitEmail(visit: { address: string; category: string; tenantName: string }) {
  return {
    subject: `Visit needed: ${visit.category} at ${visit.address}`,
    text: `Please book a visit to ${visit.address}.\n\nWhat: ${visit.category}\nTenant: ${visit.tenantName}\n\nReply to this email with a date.`,
  };
}
