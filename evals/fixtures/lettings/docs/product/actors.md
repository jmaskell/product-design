# Actors

| Actor | Kind | Jobs |
|---|---|---|
| Tenant | user | T1 Get a problem in the home fixed without chasing |
| Letting agent | internal role | A1 Keep every repair moving to done within the agreed time |
| Landlord | external actor | L1 Keep the property in good repair at a fair cost |
| Contractor | external actor | C1 Get clear jobs and get paid |
| Repairs inbox | system | — |

| From | Verb | To | What |
|---|---|---|---|
| Tenant | requests | Letting agent | repair report |
| Letting agent | requests | Landlord | approval over £250 |
| Landlord | decides | Letting agent | approve / decline |
| Letting agent | hands off to | Contractor | job by email |
| Contractor | informs | Letting agent | job done |
| Letting agent | informs | Tenant | status |
