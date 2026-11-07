# Threat model (starter — expand during M3)

## Assets
- Home lab services and the data on them (photos, files, course work)
- The cloud instance and its public status page
- My admin access itself (SSH keys, cloud console, VPN keys)

## What I am actually defending against (lab-realistic)
- Internet background noise: automated SSH/password guessing against anything public
- Credential mistakes by me: a management interface accidentally left public
- Silent failure: a service or the home connection dying while I am away

## Detections planned (M3), MITRE ATT&CK mapped

| Detection | Source | ATT&CK |
|---|---|---|
| Repeated failed SSH authentication | Auth logs via SIEM agent | T1110 Brute Force |
| Unauthorized change to a watched config file | File integrity monitoring | T1565 / defense evasion context — record the exact technique ID at write-up time after verifying it |
| New listening service on a monitored host | SIEM / port inventory diff | T1571 Non-Standard Port (verify at write-up) |

Rule for this file: a technique ID goes in only after it has been checked against the current ATT&CK matrix. No guessing IDs from memory in employer-facing material.
