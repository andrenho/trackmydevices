data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_api_gateway_rest_api" "api" {
  name = "trackmd"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  body = templatefile("api.json", {
    region                  = "${data.aws_region.current.name}"
    account                 = "${data.aws_caller_identity.current.account_id}"
    user_function_name      = "${data.aws_lambda_function.database.function_name}"
    track_request_template  = jsonencode(templatefile("track.request.template", {}))
    track_response_template = jsonencode(templatefile("track.response.template", {}))
  })
}

resource "aws_api_gateway_deployment" "prod" {
  depends_on  = ["aws_api_gateway_rest_api.api"]
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = ""
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  deployment_id = "${aws_api_gateway_deployment.prod.id}"
}

resource "aws_api_gateway_base_path_mapping" "test" {
  base_path   = "v1"
  api_id      = "${aws_api_gateway_rest_api.api.id}"
  stage_name  = "prod"
  domain_name = "${aws_api_gateway_domain_name.gamesmith.domain_name}"
}
