resource "aws_sns_topic" "test" {
  name = var.name
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.test.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      #"SNS:Subscribe",
      #"SNS:SetTopicAttributes",
      #"SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      #"SNS:ListSubscriptionsByTopic",
      #"SNS:GetTopicAttributes",
      #"SNS:DeleteTopic",
      #"SNS:AddPermission",
    ]

#    condition {
#      test     = "StringEquals"
#      variable = "AWS:SourceOwner"
#    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.test.arn,
    ]

    sid = "__default_statement_ID"
  }
}










resource "aws_cloudwatch_metric_alarm" "foobar" {
    actions_enabled           = true
    alarm_actions             = aws_sns_topic.test.*.arn
    alarm_name                = "sms-alarm"
    comparison_operator       = "GreaterThanThreshold"
    datapoints_to_alarm       = 1
    dimensions                = {
        "TopicName" = "output"
    }
    evaluation_periods        = 1
    insufficient_data_actions = []
    metric_name               = "NumberOfMessagesPublished"
    namespace                 = "AWS/SNS"
    ok_actions                = []
    period                    = 86400
    statistic                 = "Average"
    tags                      = {}
    threshold                 = 1
    treat_missing_data        = "missing"
}

resource "aws_cloudwatch_metric_alarm" "foobar1" {
    actions_enabled           = true
    alarm_actions             = aws_sns_topic.test.*.arn
    alarm_name                = "billing-alarm"
    comparison_operator       = "GreaterThanThreshold"
    datapoints_to_alarm       = 1
    dimensions                = {
        "Currency" = "USD"
    }
    evaluation_periods        = 1
    insufficient_data_actions = []
    metric_name               = "EstimatedCharges"
    namespace                 = "AWS/Billing"
    ok_actions                = []
    period                    = 21600
    statistic                 = "Maximum"
    tags                      = {}
    threshold                 = 80
    treat_missing_data        = "missing"
}

