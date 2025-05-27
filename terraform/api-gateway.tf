module "api_gateway" {
  source = "./modules/api-gateway"

  api_name        = "products-service-api"
  api_description = "API Gateway for products management service"
}

output "api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = module.api_gateway.api_endpoint
}
