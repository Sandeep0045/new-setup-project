resource "aws_instance" "myec2" {
   ami = "ami-042e8287309f5df03"
   instance_type = "t2.micro"
   key_name = "new"
   tags = {
    Name = "AWS DEMO Server"
  }
}
