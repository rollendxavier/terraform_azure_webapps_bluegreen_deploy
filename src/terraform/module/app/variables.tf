# Input variable: Web App
variable "location" {
  description = "Location of the resource"
  default     = "Australia East"
}

variable "environment" {
  description = "Environment tag of the resource"
  default     = "test"
}

variable "app_name" {
  description = "Web application name."
  default     = "web-app"
}

variable "acr_name" {
  description = "ACR container name where images are hosted."
}

variable "acr_id" {
  description = "ACR container id where images are hosted."
}
