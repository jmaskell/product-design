// All email goes through Postmark. Postmark's servers are in the United States.
import { ServerClient } from "postmark";
export const mail = new ServerClient(process.env.POSTMARK_TOKEN);
