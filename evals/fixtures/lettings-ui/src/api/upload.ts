export async function uploadPhoto(file: File): Promise<string | undefined> {
  try {
    const body = new FormData();
    body.append("photo", file);
    const res = await fetch("/api/photos", { method: "POST", body });
    return (await res.json()).url;
  } catch {
    return undefined;
  }
}
