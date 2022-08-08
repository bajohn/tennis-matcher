
resource "aws_lambda_function" "tennismatcher-api" {
  filename      = "../artifacts/lambda_function_payload.zip"
  function_name = "tennismatcher-api"
  role          = aws_iam_role.iam_for_tennismatcher_api_lambda.arn
  handler       = "index.handler"

  source_code_hash = filebase64sha256( "../artifacts/lambda_function_payload.zip")

  runtime = "nodejs12.x"
}

resource "aws_iam_role" "iam_for_tennismatcher_api_lambda" {
  name = "iam_for_tennismatcher_api_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "tennismatcher-lambda-dynamo-attachment" {
  name       = "tennismatcher-lambda-dynamo-attachment"
  roles      = [aws_iam_role.iam_for_tennismatcher_api_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

