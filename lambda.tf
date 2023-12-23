data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name                = "${var.lambda_name}-execution-role"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

  lifecycle {
    ignore_changes = [
      managed_policy_arns
    ]
  }
}

data "archive_file" "hello_world" {
  type        = "zip"
  source_file = "${path.module}/src/index.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_name
  description   = var.lambda_description
  memory_size   = var.lambda_memory_size

  filename         = "${path.module}/lambda.zip"
  handler          = "index.handler"
  runtime          = var.lambda_python_runtime
  role             = aws_iam_role.iam_for_lambda.arn
  source_code_hash = data.archive_file.hello_world.output_base64sha256

  lifecycle {
    ignore_changes = [
    ]
  }
}
