# Lambda function
variable "lambda_name" {
  description = "Lambda function name"
  default     = "hello-world"
  type        = string
}

variable "lambda_description" {
  description = "Lambda function description"
  default     = "It says hello world"
  type        = string
}

variable "lambda_memory_size" {
  description = "Lambda function memory"
  default     = 128
  type        = number
}

variable "lambda_python_runtime" {
  description = "Python runtime used in Lambdda"
  default     = "python3.12"
  type        = string
}

# API Gateway
variable "api_gateway_throttling_rate_limit" {
  description = "API gateway throttling rate lmit in requests per second"
  default     = 3
  type        = number
}

variable "api_gateway_throttling_burst_limit" {
  description = "API gateway throttling burst limit in number of requests"
  default     = 5
  type        = number
}
