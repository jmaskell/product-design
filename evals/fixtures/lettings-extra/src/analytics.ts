// Product events.
export function track(event: "repair_reported" | "approval_sent", props: Record<string, unknown> = {}) {
  console.log(JSON.stringify({ event, ...props }));
}
