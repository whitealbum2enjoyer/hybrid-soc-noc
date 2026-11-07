# On-prem side (anzu)

- Monitoring agents (node_exporter / SIEM agents) are installed per-host during M2/M3, not from a single compose file — the hosts are Proxmox containers and VMs, not one Docker host.
- The SIEM itself (M3) runs in its own Proxmox VM on the SATA/LVM storage pool (the root disk is 84% full — do not use it), with short log retention and few agents. Headroom was measured before committing to this; see the project page in Notion for the numbers.
- Fallback if the SIEM is too heavy for the host: run it in a VM on the desktop PC during lab sessions only.
