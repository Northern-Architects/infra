variable "region" {
  description = "Azure infrastructure region"
  type        = string
  default     = "canadaeast"
}

variable "app" {
  description = "Application's info'"
  type        = string
  default     = "juicyapp"
}

variable "env" {
  description = "Application's env"
  type        = string
  default     = "dev"
}

