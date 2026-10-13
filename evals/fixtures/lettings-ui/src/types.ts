export type RepairStatus = "reported" | "booked" | "fixed" | "cancelled";

export interface Repair {
  id: string;
  category: string;
  status: RepairStatus;
  reportedAt: Date;
  updatedAt: Date;
  contractorName?: string;
}
