# Hybrid SOC/NOC Lab — Oracle Cloud side
# Milestone 1 skeleton. NOT applied yet.
# Requires: OCI API key auth configured (see variables.tf) and the tenancy's
# home region verified in the console — Always Free resources can only be
# created in the home region.
#
# Always Free budget this must stay inside (verified from Oracle docs, Nov 2026):
#   - Ampere A1 Flex: 2 OCPU / 12 GB RAM total across ALL A1 instances
#   - Block storage: 200 GB total (min boot volume 47 GB per instance)
#   - Plus up to 2x VM.Standard.E2.1.Micro (AMD, 1 GB each)

terraform {
  required_version = ">= 1.5"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.api_key_fingerprint
  private_key_path = var.api_key_path
  region           = var.region
}

# --- Network: VCN 10.20.0.0/16 -------------------------------------------
resource "oci_core_vcn" "lab" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = ["10.20.0.0/16"]
  display_name   = "soc-noc-lab"
  dns_label      = "socnoclab"
}

# TODO M1: internet gateway + route table for the public subnet
# TODO M1: NAT gateway (or none) decision for the private subnet — document why
# TODO M1: oci_core_subnet public  10.20.1.0/24
# TODO M1: oci_core_subnet private 10.20.2.0/24 (prohibit_public_ip_on_vnic = true)
# TODO M1: oci_core_network_security_group mgmt — default deny; allow UDP 51820
#          from home public IP only; allow 443 to status page service only

# --- Compute: ONE A1 instance using the full Always Free allowance -------
# TODO M1: oci_core_instance cloud_node
#   shape = "VM.Standard.A1.Flex", shape_config { ocpus = 2, memory_in_gbs = 12 }
#   boot volume 50 GB (stays inside the 200 GB total with room to spare)
#   assign_public_ip on the public-subnet VNIC; second VNIC in private subnet if needed

# TODO M1: output the instance public IP and private VCN IP for the runbook
