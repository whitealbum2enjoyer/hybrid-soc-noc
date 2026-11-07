# Hybrid SOC / NOC Lab

A two-site infrastructure lab I design, build, and operate myself:

- **Site A (on-prem):** a Proxmox server running Linux containers and VMs (DNS, VPN, file/photo services, and a SIEM)
- **Site B (cloud):** an Oracle Cloud Always Free tenancy (ARM instance, Terraform-managed virtual cloud network)
- **Link:** a WireGuard site-to-site tunnel between the two sites

Oracle handles **availability monitoring** — it can tell the outside world (and me) when home is down, because it does not depend on home being up. The on-prem site handles **security analysis** — centralized logs, detections, and incident investigation. Detailed dashboards are only reachable over the private tunnel. The public status page shows generic service health only: no addresses, hostnames, versions, or tooling details.

> Status: **Milestone 1 in progress** — cloud networking. See the milestone checklist below.

## What this proves

| Skill area | Where the proof lives |
|---|---|
| Cloud networking | `terraform/` — VCN, public/private subnets, route tables, network security groups |
| Network engineering | `docs/network-design.md` — IP plan, tunnel design, routing, firewall rules |
| Monitoring / NOC operations | `compose/` + `dashboards/` — Prometheus, Grafana, Uptime Kuma, alert rules |
| Security operations | `docs/threat-model.md`, `docs/incidents/` — Wazuh SIEM, MITRE ATT&CK-mapped detections, incident reports |
| Troubleshooting | `docs/runbooks/` — step-by-step recovery procedures I wrote and tested |
| Automation | Terraform for infrastructure; a Python reporting tool is planned *after* the core works |

## Architecture

See [docs/architecture.md](docs/architecture.md) for the diagram and design decisions.

## Milestones

- [ ] **M1 — Cloud networking:** Terraform-deployed cloud network + VM, WireGuard tunnel to on-prem, restrictive firewall rules, routing verified and documented
- [ ] **M2 — NOC observability:** uptime + metrics monitoring for both sites, one meaningful alert, a simulated outage detected and recovered using a runbook
- [ ] **M3 — SOC monitoring:** SIEM running on-prem, Linux + Windows agents enrolled, a controlled failed-login exercise detected and investigated, an incident report written, a planted misconfiguration remediated and verified

Deferred until M1-M3 work reliably: SSO, Python reporting, extra dashboards.

## Incidents

| # | Scenario | Primary skill |
|---|---|---|
| 1 | VPN tunnel goes down | Network troubleshooting and recovery |
| 2 | Repeated failed SSH authentication | Security detection and investigation |
| 3 | Unauthorized configuration change | File integrity monitoring and remediation |

Each incident report follows the same structure: initial evidence, detection, investigation, root cause, remediation, verification, lessons learned. All exercises run against my own isolated lab systems.

## Honest scope

This is a personal lab, not a production environment. Scale, retention, and availability are lab-scale and described as such. Any metric on this page (endpoints monitored, detection time, recovery time) is measured in the lab and will be published only after I have actually measured it.
