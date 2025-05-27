resource "aws_lambda_function" "function" {
  function_name    = var.function_name
  role             = var.lambda_role_arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.zip_file
  source_code_hash = var.source_code_hash

  memory_size = 384
  timeout     = 30

  environment {
    variables = var.environment_variables
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration_post" {
  api_id           = var.api_gateway_id
  integration_type = "AWS_PROXY"

  integration_uri        = aws_lambda_function.function
  integration_method     = "POST"
  payload_format_version = "2.0"
}

/* resource "aws_apigatewayv2_integration" "lambda_integration_get" {
  api_id           = var.api_gateway_id
  integration_type = "AWS_PROXY"

  integration_uri        = aws_lambda_function.function.invoke_arn
  integration_method     = "GET"
  payload_format_version = "2.0"
} */

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_authorizer" {
  statement_id  = "AllowAPIGatewayInvokeAuthorizer"
  action        = "lambda:InvokeFunction"
  function_name = "arn:aws:lambda:us-west-1:590183686443:function:jwt-authorizer"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}

