data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Test vm"
  }
}

resource "aws_instance" "test_vm_to_import" {
  ami           = "ami-07c8c1b18ca66bb07"
  instance_type = "t3.micro"

  tags = {
    "Name" = "test vm to import"
  }
}

module "s3_bucket" {
  source      = "github.com/Hari0o/module-s3-bucket"
  bucket_name = "randombucketnames849393"
}