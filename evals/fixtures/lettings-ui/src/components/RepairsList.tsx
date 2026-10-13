import { Repair } from "../types";

export function RepairsList({ repairs }: { repairs: Repair[] }) {
  return (
    <section>
      <h1>Your repairs</h1>
      <table>
        <thead>
          <tr>
            <th>Repair</th>
            <th>Status</th>
            <th>Reported</th>
          </tr>
        </thead>
        <tbody>
          {repairs.map((r) => (
            <tr key={r.id}>
              <td>{r.category}</td>
              <td>{r.status}</td>
              <td>{r.reportedAt.toLocaleDateString("en-GB")}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
