resource "aws_apigatewayv2_api" "hello_world" {
  name          = "hello-world-api"
  description   = "Hello world HTTP API"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "hello_world_lambda" {
  api_id           = aws_apigatewayv2_api.hello_world.id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  description        = "Hello world lambda"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.hello_world.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.hello_world_lambda.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.hello_world.id
  name        = "dev"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = var.api_gateway_throttling_burst_limit
    throttling_rate_limit  = var.api_gateway_throttling_rate_limit
  }
}

resource "aws_apigatewayv2_deployment" "hello_world" {
  api_id      = aws_apigatewayv2_api.hello_world.id
  description = "Hello world deployment"
  depends_on  = [aws_apigatewayv2_integration.hello_world_lambda, aws_apigatewayv2_route.default]

  triggers = {
    redeployment = sha1(join(",", tolist([
      jsonencode(aws_apigatewayv2_integration.hello_world_lambda),
      jsonencode(aws_apigatewayv2_route.default)
    ])))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.hello_world.execution_arn}/*/$default"
}
