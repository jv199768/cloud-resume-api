
resource "aws_lambda_function" "example" {
  function_name = "aws_resume_python"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "s3demo01025025abc"
  s3_key    = "lambda_function.zip"
  role = "${aws_iam_role.lambda_exec.arn}"
  handler = "lambda_function.handler"
  runtime = "python3.12"

  # (leave the remainder unchanged)
}
# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

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
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.example.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.example.execution_arn}/*/*"
}
