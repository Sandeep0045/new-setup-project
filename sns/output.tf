output "arn" {
  description = "ARN of SNS topic"
  value       = element(concat(aws_sns_topic.test.*.arn, [""]), 0)
}
