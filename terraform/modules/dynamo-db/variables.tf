variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "products"
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Partition key name"
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "Partition key type"
  type        = string
  default     = "S"
}

variable "gsi_name" {
  description = "Name of the GSI"
  type        = string
  default     = "NameIndex"
}

variable "gsi_key" {
  description = "GSI partition key"
  type        = string
  default     = "name"
}

variable "gsi_key_type" {
  description = "GSI partition key type"
  type        = string
  default     = "S"
}

variable "gsi_projection_type" {
  description = "ProjectionType for the GSI"
  type        = string
  default     = "ALL"
}
