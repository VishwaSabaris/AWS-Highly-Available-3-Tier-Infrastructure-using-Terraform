terraform {
  backend "s3" {
    bucket = "vishwa-terraform-state-12345"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

