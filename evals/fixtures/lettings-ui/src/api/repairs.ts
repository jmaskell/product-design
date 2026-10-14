import { Repair } from "../types";

export async function listRepairs(): Promise<Repair[]> {
  const res = await fetch("/api/repairs");
  return res.json();
}

export const newestFirst = (a: Repair, b: Repair) =>
  b.updatedAt.getTime() - a.updatedAt.getTime();
