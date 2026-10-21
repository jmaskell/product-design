# Lenses

## How to use a lens

A lens is a list of questions that one role brings to the product model. It is not a persona.
Each row has three parts: the question, its home in the model, and what Claude can check from code or a site.
Ask only the rows inside the agreed model depth or launch tier.
A question with no answer in the model is `UNKNOWN`: a question for the owner, not a defect.
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

## Support and ops

| Question | Home in the model | What Claude can check |
|---|---|---|
| What do staff see when this goes wrong? | Journey Backstage | Admin screens, logs and alerts |
| What can staff fix, and how? | actors.md (internal role) jobs | Admin actions and support tools |
| How does a user recover without help? | Journey Task flow (Failure → recovery) | Undo only where it truly reverses the action, or during a hold window before an effect leaves the app (references/product-behaviour.md); otherwise a named follow-up action (withdraw, refund, send a correction); retry and self-service paths |
| Does support need to know before release? | issue.md `**Launch:**` | Nothing: this is a launch decision |

## Compliance

Give readings and build the case for the owner's position. Never give a verdict. Never send the owner to get approval from someone else.
A rule with no recorded interpretation (`Interpretation: UNKNOWN`, or no `Interpretation:` line) gets `## Readings of a rule`.

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which rule applies, and what is its source? | Capabilities and Constraints | Nothing: the owner names the rule |
| What is our interpretation, and why is the risk acceptable? | Capabilities and Constraints | Code against the recorded interpretation |
| Which steps does the rule touch (notice, consent, disclosure, a record), and where? | Journey stages; Capabilities and Constraints | The screens, fields and writes at those steps |
| How long do we keep each record? | Capabilities and Constraints | Retention jobs and delete paths |

## Privacy

Give readings and build the case for the owner's position. Never give a verdict. Never send the owner to get approval from someone else.
A rule with no recorded interpretation gets `## Readings of a rule`.

| Question | Home in the model | What Claude can check |
|---|---|---|
| Which personal data do we hold? | Capabilities and Constraints | Personal fields in the schema |
| For which purpose, and on which basis? | Capabilities and Constraints | Nothing: the owner records the purpose and the basis |
| How long do we keep it? | Capabilities and Constraints | Retention jobs and scheduled deletes |
| Which processors receive it, in which countries? | Platform; actors.md (kind: system) | Third-party SDKs, API clients and their regions |
| How does a person see their data? | Journey stages | An access or download path |
| How does a person export it? | Journey stages | An export path |
| How does a person delete it? | Journey stages; Backstage | A delete path that reaches every store and processor, or the recorded exception (legal retention, backups) |

A right the regime does not grant is not a gap.

Use the terms of the regime the owner names in Capabilities and Constraints. If none is named, keep the neutral questions and ask which regime applies.
Summary as of 2026-10-11. Check the current law before relying on a cell.

| Concept | GDPR / UK GDPR | CCPA/CPRA | Others |
|---|---|---|---|
| Reason to process | Lawful basis | No lawful-basis rule; notice at collection; reasonably necessary and proportionate (§1798.100(c)) | LGPD: legal basis. PIPEDA: consent. Australian Privacy Act: collection reasonably necessary (APP 3); use for the primary purpose (APP 6). HIPAA: permitted uses: treatment, payment, health care operations |
| A person sees their data | Right of access | Right to know | LGPD, PIPEDA, Australian Privacy Act: access. HIPAA: right of access |
| A person deletes their data | Right to erasure | Right to delete | LGPD: deletion. PIPEDA: no general right; withdraw consent (4.3.8); destroy when no longer needed (4.5.3). Australian Privacy Act: no general right; destroy or de-identify when no longer needed (APP 11.2). HIPAA: no general right |
| Data goes to another company | Processor; international transfer | Service provider; sale or share, opt-out | LGPD: international transfer. PIPEDA: transfer for processing; the organisation stays accountable (4.1.3). Australian Privacy Act: cross-border disclosure (APP 8). HIPAA: business associate |
| Sensitive data | Special category data | Sensitive personal information | LGPD: sensitive data. PIPEDA: no defined sensitive class; sensitivity depends on context. Australian Privacy Act: sensitive information. HIPAA: protected health information (PHI) is the whole regulated data set, not a subset |

## CEO

A summary of the other lenses: purpose, who, evidence, the 3 biggest risks.

## Launch tiers

| Tier | When | Questions |
|---|---|---|
| 0 Internal | A tool for our own staff | Who uses it and what they use today; how they learn it (training, a walkthrough, a champion); how the old way stops; what shows they adopted it |
| 1 Quiet | A small change for existing users, who need to learn nothing new | Where they meet it at the moment of need; whether support needs to know |
| 2 Feature | A change existing users must notice, or that drives upgrade. A change that helps only after people learn to do something new is tier 2, even when it is small | Which segment gains; the one-line message; where they learn of it; adoption signal; who in sales or support needs a brief |
| 3 Launch | A new product, market or repositioning | Full product level: alternatives incl. "do nothing", category, segment, the four forces (Moesta), promise vs first value, claims vs proof, the path from discovery to first value through the real start path (self-serve, or demo, pilot and contract) |

Tier 1 test: people do what they did before and see more. If they must act in a new way, or the product must tell them how, it is tier 2.
Channels (changelog, in-app, email) are examples, not steps. Never ask a lower tier the questions of a higher tier.
The PRODUCT.md `Market` section holds the product-level tier 3 answers: alternatives, category, segment traits and losses. issue.md `## Launch` holds the answers for one change.

## Readings of a rule

For a rule with no recorded interpretation (`Interpretation: UNKNOWN`, or no `Interpretation:` line), give 2–3 readings, from cautious to assertive.
Write each reading as `<reading> — because <argument> — lets the product <what> — risk: <risk>`.
The argument is the strongest case for that reading, the assertive one too. The risk of the cautious reading is what the product gives up. You may name a lean, as `Lean: <reading> — because <argument>`; the owner picks.
No reading waits on sign-off or a ruling from legal, an expert or anyone else. The owner's pick decides.
Claude never picks a reading silently.
Record the pick in the PRODUCT.md Capabilities and Constraints row: rule + source; interpretation; why the risk is acceptable; `KNOWN (owner, <date>)`.
Until the owner picks, write `Interpretation: UNKNOWN` with the readings.
