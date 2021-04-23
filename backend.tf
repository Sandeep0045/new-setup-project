terraform {
  backend "s3" {
    bucket = "statefiles-01"
    key    = "sns.tfstate"
    region = "us-east-1"

}
}
