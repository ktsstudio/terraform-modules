variable "name" {
  type = string
}

variable "acl" {
  type    = string
  default = "private"
}

variable "default_storage_class" {
  type    = string
  default = "STANDARD"
}

variable "endpoint_url" {
  type    = string
  default = "https://storage.yandexcloud.net"
}

variable "cors_enabled" {
  type        = bool
  default     = false
  description = "Activate adding of CORS rules"
}

variable "cors_allowed_headers" {
  type        = list(string)
  default     = []
  description = "List of allowed headers for CORS rules"
}

variable "cors_allowed_methods" {
  type        = list(string)
  default     = []
  description = "List of allowed methods for CORS rules"
}

variable "cors_allowed_origins" {
  type        = list(string)
  default     = []
  description = "List of allowed origins for CORS rules"
}

variable "cors_expose_headers" {
  type        = list(string)
  default     = []
  description = "List of allowed expose headers"
}

variable "cors_max_age_seconds" {
  type        = number
  default     = 0
  description = "Max age of cors in seconds"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Bucket tags"
}

variable "delete_incomplete_multipart_upload_days_enabled" {
  type    = bool
  default = false
}

variable "delete_incomplete_multipart_upload_days" {
  type    = number
  default = 7
}
