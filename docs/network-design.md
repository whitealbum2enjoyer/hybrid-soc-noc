# Network design

## Address plan

Ranges already in use at home (measured, Nov 2026) — the cloud design must not collide with any of these:

| Range | Used for |
|---|---|
| 192.168.4.0/22 | Home lab LAN (Proxmox bridge, all containers) |
| 192.168.1.0/24 | Internal bridge reserved for a firewall VM (currently down) |
| 10.0.0.0/24 | Existing personal WireGuard VPN (separate from this project) |
| 100.64.0.0/10 | Tailscale (CGNAT range) |

New ranges for this project:

| Range | Used for |
|---|---|
| 10.20.0.0/16 | Oracle VCN (whole cloud site) |
| 10.20.1.0/24 | VCN public subnet — cloud VM, status page |
| 10.20.2.0/24 | VCN private subnet — no public IPs, reachable only via tunnel |
| 10.99.0.0/30 | Site-to-site WireGuard transit (anzu side .1, Oracle side .2) |

## Tunnel design

- A **new** WireGuard interface for site-to-site, separate from the existing personal VPN, so the two can be managed and torn down independently.
- AllowedIPs on each side route only the other site's ranges — no default-route-over-tunnel.
- Management traffic (monitoring scrape, SIEM agent traffic, admin access) rides the tunnel. Nothing else.

## Firewall posture

- Cloud side: Network Security Groups default-deny inbound; allow only the WireGuard UDP port from home's public IP and HTTPS to the status page.
- Home side: no new inbound port forwards except WireGuard; the tunnel is initiated/kept alive from home where possible.

## Verification (fill in during M1)

- [ ] From cloud VM: ping + curl a private home service over the tunnel
- [ ] From home: ping + SSH the cloud VM's private VCN address
- [ ] Kill the tunnel: confirm the cloud availability monitor detects the home outage and alerts
- [ ] Confirm no management interface answers on a public address (external port scan of both public IPs)
