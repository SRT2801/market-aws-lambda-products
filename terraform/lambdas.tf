module "lambda_shared" {
  source             = "./modules/shared-resources"
  role_name          = "products_lambda_role"
  dynamodb_table_arn = module.dynamodb.table_arn
}

# Create products Lambda
module "create_products" {
  source = "./modules/lambda"

  function_name             = "create-products"
  lambda_role_arn           = module.lambda_shared.lambda_role_arn
  zip_file                  = "${path.module}/../lambdas/create-products"
  source_code_hash          = filebase64sha256("${path.module}/../lambdas/create-products.zip")
  api_gateway_id            = module.api_gateway.api_id
  api_gateway_execution_arn = module.api_gateway.execution_arn

  environment_variables = {
    ENV         = "dev"
    USERS_TABLE = module.dynamodb.table_name
  }
}

# Get products Lambda
/* module "get_products" {
  source = "./modules/lambda"

  function_name             = "get-products"
  lambda_role_arn           = module.lambda_shared.lambda_role_arn
  zip_file                  = "${path.module}/../lambdas/get-products.zip"
  source_code_hash          = filebase64sha256("${path.module}/../lambdas/get-products.zip")
  api_gateway_id            = module.api_gateway.api_id
  api_gateway_execution_arn = module.api_gateway.execution_arn

  environment_variables = {
    ENV            = "dev"
    USERS_TABLE    = module.dynamodb.table_name
  }
}
 */
# Api Gateway Routes
resource "aws_apigatewayv2_route" "create_products_route" {
  api_id    = module.api_gateway.api_id
  route_key = "POST /products"
  target    = "integrations/${module.create_products.integration_id}"
  authorization_type = "CUSTOM"
  authorizer_id = aws_apigatewayv2_authorizer.jwt_authorizer.id
}

/* resource "aws_apigatewayv2_route" "get_products_route" {
  api_id    = module.api_gateway.api_id
  route_key = "GET /products"
  target    = "integrations/${module.get_products.integration_id}"
  authorization_type = "CUSTOM"
  authorizer_id = aws_apigatewayv2_authorizer.jwt_authorizer.id
}
 */
