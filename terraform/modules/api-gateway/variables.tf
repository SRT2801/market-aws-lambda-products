variable "api_name" {
  description = "Product's API Gateway"
  type        = string
  default     = "products-api"
}

variable "api_description" {
  description = "API Gateway for products service"
  type        = string
  default     = "Product's service API Gateway"
}

variable "auto_deploy" {
  description = "Enable automatic deployment when routes/integrations change"
  type        = bool
  default     = true
}

variable "stage_name" {
  description = "Default stage name"
  type        = string
  default     = "$default"
}
