variable "tenancy_ocid" {
  description = "OCI tenancy OCID (from the console: Profile > Tenancy). Never commit a real value — use terraform.tfvars, which is gitignored."
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID for API key auth."
  type        = string
}

variable "api_key_fingerprint" {
  description = "Fingerprint of the API signing key uploaded to the OCI console."
  type        = string
}

variable "api_key_path" {
  description = "Local path to the API private key PEM. The key itself is never committed."
  type        = string
}

variable "region" {
  description = "OCI home region (e.g. us-ashburn-1). Always Free resources can ONLY be created in the home region — verify yours in the console before applying."
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment to create resources in. Defaults to the tenancy root if you set it to the tenancy OCID."
  type        = string
}

variable "home_public_ip" {
  description = "Home public IP allowed to reach the WireGuard endpoint. Used in the NSG rule."
  type        = string
}
