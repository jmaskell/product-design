#!/usr/bin/env bash
# Copies lettings-ui and adds the letting-agent side: applicants, listings, payments and the tenant's plan page.
set -euo pipefail
fx="$(cd "$(dirname "$0")" && pwd)"
cp -R "$fx/lettings-ui/." .
printf -- '\nAgents (letting-agency staff) work in src/agent/; tenants in src/tenant/ and src/components/.\n' >> AGENTS.md
mkdir -p src/agent src/tenant

cat >> src/types.ts <<'EOF'

export interface Listing {
  id: string;
  address: string;
  rentMonthly: number;
  deposit: number;
  termMonths: number;
}

export type ApplicantStatus = "new" | "contacted" | "offered" | "withdrawn" | "closed";

export interface Applicant {
  id: string;
  status: ApplicantStatus;
  ownerId: string;
  appliedAt: Date;
  name: string;
  email: string;
  phone: string;
  currentAddress: string;
  moveInDate: Date;
  employer: string;
  income: number;
  householdSize: number;
  pets: boolean;
  smoker: boolean;
  guarantor: string | null;
  references: string[];
  consentToChecks: boolean;
  notes: string;
}

export interface Payment {
  id: string;
  tenantId: string;
  amount: number;
  takenAt: Date | null;
}
EOF

cat > src/api/applicants.ts <<'EOF'
import { Applicant } from "../types";

export async function getApplicant(id: string): Promise<Applicant> {
  return (await fetch(`/api/applicants/${id}`)).json();
}
export async function listApplicants(): Promise<Applicant[]> {
  return (await fetch("/api/applicants")).json();
}
// Emails the offer to the applicant as soon as it is called.
export async function sendOffer(applicantId: string, listingId: string): Promise<{ offerId: string }> {
  return (await fetch("/api/offers", { method: "POST", body: JSON.stringify({ applicantId, listingId }) })).json();
}
export async function withdrawOffer(offerId: string): Promise<void> {
  await fetch(`/api/offers/${offerId}/withdraw`, { method: "POST" });
}
export async function archiveRepair(id: string): Promise<void> {
  await fetch(`/api/repairs/${id}/archive`, { method: "POST" });
}
export async function unarchiveRepair(id: string): Promise<void> {
  await fetch(`/api/repairs/${id}/unarchive`, { method: "POST" });
}
EOF

cat > src/api/listings.ts <<'EOF'
import { Listing } from "../types";

export async function getListing(id: string): Promise<Listing> {
  return (await fetch(`/api/listings/${id}`)).json();
}
export async function listListings(): Promise<Listing[]> {
  return (await fetch("/api/listings")).json();
}
EOF

cat > src/api/payments.ts <<'EOF'
import { Payment } from "../types";

export async function listPayments(tenantId: string): Promise<Payment[]> {
  return (await fetch(`/api/tenants/${tenantId}/payments`)).json();
}
export async function refundPayment(paymentId: string): Promise<void> {
  await fetch(`/api/payments/${paymentId}/refund`, { method: "POST" });
}
EOF

cat > src/agent/ApplicantsList.tsx <<'EOF'
import { Applicant } from "../types";

export function ApplicantsList({ applicants }: { applicants: Applicant[] }) {
  return (
    <section>
      <h1>Applicants</h1>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Status</th>
            <th>Applied</th>
          </tr>
        </thead>
        <tbody>
          {applicants.map((a) => (
            <tr key={a.id}>
              <td><a href={`/agent/applicants/${a.id}`}>{a.name}</a></td>
              <td>{a.status}</td>
              <td>{a.appliedAt.toLocaleDateString("en-GB")}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
EOF

cat > src/agent/ApplicantPage.tsx <<'EOF'
import { Applicant } from "../types";

export function ApplicantPage({ applicant: a }: { applicant: Applicant }) {
  return (
    <section>
      <h1>{a.name}</h1>
      <dl>
        <dt>Email</dt><dd>{a.email}</dd>
        <dt>Phone</dt><dd>{a.phone}</dd>
        <dt>Current address</dt><dd>{a.currentAddress}</dd>
        <dt>Move-in date</dt><dd>{a.moveInDate.toLocaleDateString("en-GB")}</dd>
        <dt>Employer</dt><dd>{a.employer}</dd>
        <dt>Income</dt><dd>£{a.income.toLocaleString("en-GB")}</dd>
        <dt>Household size</dt><dd>{a.householdSize}</dd>
        <dt>Pets</dt><dd>{a.pets ? "Yes" : "No"}</dd>
        <dt>Smoker</dt><dd>{a.smoker ? "Yes" : "No"}</dd>
        <dt>Guarantor</dt><dd>{a.guarantor ?? "None"}</dd>
        <dt>References</dt><dd>{a.references.join(", ")}</dd>
        <dt>Consent to checks</dt><dd>{a.consentToChecks ? "Yes" : "No"}</dd>
        <dt>Notes</dt><dd>{a.notes}</dd>
        <dt>Status</dt><dd>{a.status}</dd>
      </dl>
    </section>
  );
}
EOF

cat > src/tenant/TenancyPlan.tsx <<'EOF'
import { Listing } from "../types";

export function TenancyPlan({ listing }: { listing: Listing }) {
  return (
    <section>
      <h1>Your tenancy plan</h1>
      <p>{listing.address}</p>
      <p>£{listing.rentMonthly.toLocaleString("en-GB")} a month for {listing.termMonths} months</p>
    </section>
  );
}
EOF

cat > src/routes.ts <<'EOF'
export const routes = {
  applicants: "/agent/applicants",
  applicant: "/agent/applicants/:id",
  tenancyPlan: "/tenant/plan",
};
EOF
