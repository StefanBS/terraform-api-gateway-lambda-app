output "invoke_url" {
  description = "URL to invoke the API"
  value       = aws_apigatewayv2_stage.dev.invoke_url
}
