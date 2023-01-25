terraform {
  backend "s3" {
    bucket               = "synth-chm-terraform"
    workspace_key_prefix = "tf-state"
    key                  = "terraform.tfstate"
    region               = "us-east-1"
  }
}