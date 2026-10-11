# Lenses

## How to use a lens

A lens is a list of questions that one role brings to the product model. It is not a persona.
Each row has three parts: the question, its home in the model, and what Claude can check from code or a site.
Ask only the rows inside the agreed model depth or launch tier.
A question with no answer in the model is `UNKNOWN`. It is not a finding.
Code shows what the system does. It never shows what people do. Tag behaviour from code `INFERRED`.
Code proves a capability, not a result. An outcome or numeric claim with no named proof is `UNKNOWN`.

## PM

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which jobs does this serve, for which actor? | actors.md jobs; issue.md `**Jobs:**` | Routes and screens that serve each job |
| What counts as done for the person? | issue.md Outcome; journey Outcome | Nothing: the outcome is in the person's words |
| Which signal shows the job succeeds? | actors.md `Signal:` | The named event exists in code |
| Which claims are not yet proven? | Evidence on Hand; issue.md Evidence ledger | Claims tagged ASSUMED or UNKNOWN |
| What do we not do, or not do for whom? | Capabilities and Constraints; Product Principles | Features in code that the model does not name |

## Designer

| Question | Home in the model | What Claude can check |
|---|---|---|
| Where does the person meet this change? | Journey stages | The entry points on the journey `Code:` line |
| What can fail at each step, and how does the person recover? | Journey Task flow | Error states, empty states and retry paths |
| Which hand-offs does the person see? | actors.md relationships; journey Backstage | Notifications and status screens |
| Which words does the person use? | Terms | Screen copy against Terms; the Avoid column |
| Which moments carry the most risk? | Journey Moments that matter | Nothing: this is a judgement |

## Engineering

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which system actors take part? | actors.md (kind: system) | Services, queues and scheduled jobs |
| Which integrations does this touch? | actors.md relationships; Platform | API clients, webhooks and SDKs |
| Who owns each piece of data? | actors.md relationships ("provides") | The schema and the writes to each table |
| What happens when a dependency fails? | Journey Task flow; Backstage | Timeouts, retries and fallbacks |
| Do the code names match the model? | Terms (Code name column) | Identifiers that drift from Terms |

## Commercial

| Question | Home in the model | What Claude can check |
|---|---|---|
| Who pays, and is that actor the user? | actors.md relationship `pays for` | Billing and account models |
| Which plan includes this, and what limits apply? | Capabilities and Constraints | Entitlement and plan checks in code |
| Does each priced feature have an entitlement check? | Capabilities and Constraints | Pricing lines with no check; checks with no pricing line |
| Which signal shows the revenue goal? | actors.md `Signal:` | Billing events |

## Marketing

| Question | Home in the model | What Claude can check |
|---|---|---|
| Who needs to know: internal staff, existing users or new customers? | Users; issue.md `**Launch:**` | Roles in code; the site's audience words |
| What do we want from it: adoption, retention, revenue or a new market? | issue.md `**Launch:**`; actors.md `Signal:` | Events that measure that goal |

Claude proposes a tier from these two answers and the size. The owner adjusts it. Pick the questions from `## Launch tiers`.

Code and site checks for tier 2 and up:
- For each claim on the site, README or store page, find the capability in code. A claim with no code path is a Phantom.
- A numeric claim ("10x faster", "99.9% uptime") with no named proof is `UNKNOWN`.
- An integration that the site names needs a client, webhook or connector in code.
- Count the steps from sign-up to the first action that gives the headline promise. An activation milestone with no event is a gap.

Consumer and B2B differ:

| Topic | Consumer | B2B |
|---|---|---|
| Who decides | One person, often the user | A buying group of 6–10; buyer, user, champion and blocker differ |
| Segment unit | Situation, motivation, moment | Account (ICP) then persona |
| Main alternative | Another app, a habit, a free tool, "do nothing" | Spreadsheet, manual process, incumbent vendor, homegrown tool, "do nothing" |
| Trigger | Category entry point: a need, time or place | A business event: growth, a new rule, a failure, a new leader |
| Positioning output | One line on a store page or ad; brand memory | A sales pitch and a comparison; proof for validation |
| Proof | Ratings, reviews, social proof, a free try | Named customers, security docs, analyst and review sites, pilots |
| Path to value | Minutes, in one session, self-serve | Days to months; setup, integration, team invite |
| Activation unit | One user | A team or an account |
| Key failure | Lost in the first session; no habit forms | No decision; the champion cannot build consensus |
| Core metrics | D1/D7/D30 retention, conversion to paid, share of search | Win rate, no-decision rate, cycle length, net revenue retention |

## Support and ops

| Question | Home in the model | What Claude can check |
|---|---|---|
| What do staff see when this goes wrong? | Journey Backstage | Admin screens, logs and alerts |
| What can staff fix, and how? | actors.md (internal role) jobs | Admin actions and support tools |
| How does a user recover without help? | Journey Task flow (Failure → recovery) | Undo, retry and self-service paths |
| Does support need to know before release? | issue.md `**Launch:**` | Nothing: this is a launch decision |

## Compliance

Give readings and build the case for the owner's position. Never give a verdict. Never send the owner to get approval from someone else.
A rule with no recorded interpretation gets `## Readings of a rule`.

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which rule applies, and what is its source? | Capabilities and Constraints | Nothing: the owner names the rule |
| What is our interpretation, and why is the risk acceptable? | Capabilities and Constraints | Code against the recorded interpretation |
| Where does the person give consent? | Journey stages | Consent fields and the screens that set them |
| What does the audit trail record? | Journey Backstage | Audit tables and log writes |
| How long do we keep each record? | Capabilities and Constraints | Retention jobs and delete paths |

## Privacy

Give readings and build the case for the owner's position. Never give a verdict. Never send the owner to get approval from someone else.

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which personal data do we hold? | Capabilities and Constraints | Personal fields in the schema |
| For which purpose, and on which basis? | Capabilities and Constraints | Nothing: the owner records the purpose and the basis |
| How long do we keep it? | Capabilities and Constraints | Retention jobs and scheduled deletes |
| Which processors receive it, in which countries? | Platform; actors.md (kind: system) | Third-party SDKs, API clients and their regions |
| How does a person see their data? | Journey stages | An access or download path |
| How does a person export it? | Journey stages | An export path |
| How does a person delete it? | Journey stages; Backstage | A delete path that reaches every store and processor |

Use the terms of the regime the owner names in Capabilities and Constraints.
Unverified: the mapping below is a summary. Quote the regime's own text when a reading depends on a term.

| Concept | GDPR / UK GDPR | CCPA/CPRA | Others |
|---|---|---|---|
| Reason to process | Lawful basis | Business purpose; notice at collection | LGPD: legal basis; PIPEDA: consent; Australian Privacy Act: primary purpose (APP 6) |
| A person sees their data | Right of access | Right to know | LGPD, PIPEDA, Australian Privacy Act: access; HIPAA: right of access |
| A person deletes their data | Right to erasure | Right to delete | LGPD: deletion; PIPEDA: withdraw consent; HIPAA: no general right |
| Data goes to another company | Processor; international transfer | Service provider; sale or share, opt-out | LGPD: international transfer; HIPAA: business associate |
| Sensitive data | Special category data | Sensitive personal information | LGPD: sensitive data; HIPAA: protected health information |

## CEO

A summary of the other lenses: purpose, who, evidence, the 3 biggest risks.

## Launch tiers

| Tier | When | Questions |
|---|---|---|
| 0 Internal | A tool for our own staff | Who uses it and what they use today; how they learn it (training, a walkthrough, a champion); how the old way stops; what shows they adopted it |
| 1 Quiet | A small change for existing users | Where they meet it at the moment of need; whether support needs to know |
| 2 Feature | A change existing users must notice, or that drives upgrade | Which segment gains; the one-line message; where they learn of it; adoption signal; who in sales or support needs a brief |
| 3 Launch | A new product, market or repositioning | Full product level: alternatives incl. "do nothing", category, segment, the four forces (Moesta), promise vs first value, claims vs proof, the path from discovery to first value |

Channels are examples, not steps. Never ask a lower tier the questions of a higher tier.
Tier 3 answers live in the PRODUCT.md `Market` section: alternatives, category, segment traits and losses.

## Readings of a rule

For a rule with no recorded interpretation, give 2–3 readings, from cautious to assertive.
For each reading, give the argument and what it lets the product do.
The owner picks. Claude never picks a reading silently.
Record the pick in the PRODUCT.md Capabilities and Constraints row: rule + source; interpretation; why the risk is acceptable; `KNOWN (owner, <date>)`.
Until the owner picks, write `Interpretation: UNKNOWN` with the readings.
