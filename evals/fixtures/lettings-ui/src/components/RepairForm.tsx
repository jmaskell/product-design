import { useState } from "react";
import { uploadPhoto } from "../api/upload";

export function RepairForm({ onSubmit }: { onSubmit: (r: { description: string; photoUrl?: string }) => void }) {
  const [description, setDescription] = useState("");
  const [photoUrl, setPhotoUrl] = useState<string>();

  async function handlePhoto(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (file) setPhotoUrl(await uploadPhoto(file));
  }

  return (
    <form onSubmit={(e) => { e.preventDefault(); onSubmit({ description, photoUrl }); }}>
      <label htmlFor="description">What needs fixing?</label>
      <textarea id="description" value={description} onChange={(e) => setDescription(e.target.value)} />
      <label htmlFor="photo">Photo</label>
      <input id="photo" type="file" accept="image/*" onChange={handlePhoto} />
      <button type="submit">Report repair</button>
    </form>
  );
}
