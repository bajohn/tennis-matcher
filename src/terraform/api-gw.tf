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
}