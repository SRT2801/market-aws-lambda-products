output "function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.function.function_name
}

output "function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.function.arn
}

output "invoke_arn" {
  description = "Invoke ARN of the Lambda function"
  value       = aws_lambda_function.function.invoke_arn
}

output "integration_id" {
  description = "ID of the API Gateway integration"
  value       = aws_apigatewayv2_integration.lambda_integration_post.id
}

output "integration_id_get" {
  description = "ID of the API Gateway GET integration"
  value       = aws_apigatewayv2_integration.lambda_integration_get.id
}
