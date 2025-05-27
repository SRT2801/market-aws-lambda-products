

resource "aws_apigatewayv2_authorizer" "jwt_authorizer" {
  api_id           = module.api_gateway.api_id
  authorizer_type  = "REQUEST"
  identity_sources = ["$request.header.Authorization"]
  name             = "jwt-authorizer"
  authorizer_uri   = "arn:aws:lambda:us-west-1:590183686443:function:jwt-authorizer"
  authorizer_payload_format_version = "2.0"
}

