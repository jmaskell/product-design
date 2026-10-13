export function Badge({ children, tone = "neutral" }: { children: React.ReactNode; tone?: "neutral" | "info" | "success" }) {
  return <span className={`badge badge-${tone}`}>{children}</span>;
}
