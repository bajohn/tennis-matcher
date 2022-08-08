resource "aws_apigatewayv2_api" "tennismatcher-api" {
  name                       = "tennismatcher"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
  description                = "Tennismatcher Websocket API. Pull 'action' out of request JSON body."
}

resource "aws_iam_role" "iam_for_tennismatcher_apigw" {
  name = "iam_for_tennismatcher_apigw"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "tennismatcher-apigw-attachment" {
  name       = "tennismatcher-apigw-attachment"
  roles      = [aws_iam_role.iam_for_tennismatcher_apigw.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  #policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_apigatewayv2_deployment" "tennismatcher-deployment" {
  api_id      = aws_apigatewayv2_api.tennismatcher-api.id
  description = "Tennis matcher deployment"
  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "tennismatcher-stage" {
  api_id = aws_apigatewayv2_api.tennismatcher-api.id
  name   = "tennismatcher-stage"
  default_route_settings {
    logging_level="INFO"
    throttling_rate_limit=1000
    throttling_burst_limit = 5000
  }
}

resource "aws_apigatewayv2_route" "default-route" {
  api_id    = aws_apigatewayv2_api.tennismatcher-api.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.default-integration.id}"
}

resource "aws_apigatewayv2_route_response" "default-route-response" {
  api_id    = aws_apigatewayv2_api.tennismatcher-api.id
  route_id = aws_apigatewayv2_route.default-route.id
  route_response_key = "$default"
}

resource "aws_apigatewayv2_integration" "default-integration" {
  api_id           = aws_apigatewayv2_api.tennismatcher-api.id
  integration_type = "AWS"

  content_handling_strategy = "CONVERT_TO_TEXT"
  description               = "Default Lambda Integration"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.tennismatcher-api.invoke_arn
  credentials_arn           = aws_iam_role.iam_for_tennismatcher_apigw.arn
  # integration_type           = "AWS_PROXY"
  # passthrough_behavior      = "WHEN_NO_MATCH"
}