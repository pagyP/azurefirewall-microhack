variable "username" {
  description = "Username for Virtual Machines"
  type        = string
  default     = "azureadmin"
}

variable "password" {
  description = "Password must meet Azure complexity requirements"
  type        = string
  default     = "HackP@ssw0rd"
}

variable "vmsize" {
  description = "Size of the VMs"
  default     = "Standard_D2_v3"
}
