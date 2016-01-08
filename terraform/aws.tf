provider "aws" {
   access_key = "secret"
   secret_key = "secret"
   region = "us-east-1"
}

resource "aws_key_pair" "neptune" {
   key_name = "neptune"
   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCtZqa3GyGLZGVXk8Bq6zXrk6HWjaq+/X6+Qev7CvUhLqXAcc9ye+ykqRSW2DNdpCTB1noqLgfYZOt8Z5rxqL2sdEslt4U0zuUElmgnEmh7kBy1er2LLZlyEt8vUR8dCqzrPJHjquTv47iVLKvyYjDgVGSv7S7NtIO7c5KD8fbvZPDs62X2mGp7qJP34i9AshSQwZeZPZhr3dqc5Xw5BTyc1iPYjkQxgWYqFXE7R5hE7ZqW2skFGxdeg10/0/Vx0m6pomzdwISzj+qZ3swDxU5WyWTXNh2mWIwltdPU7Gsj5KMofhaCg0oXrX57BV7CdwnBwa1pSqtzz1DCwFv1XCr neil@neptune"
}

resource "aws_security_group" "ssh" {
   name = "ssh"
   description = "Allow inbound ssh"
   ingress = {
      from_port = 0
      to_port   = 22
      protocol  = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
   }
}

resource "aws_security_group" "http" {
   name = "http"
   description = "Allow inbound http"
   ingress = {
      from_port = 0
      to_port   = 80 
      protocol  = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
   }
   egress = {
      from_port = 0
      to_port   = 80
      protocol  = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
   }
   egress = {
      from_port = 0
      to_port   = 443
      protocol  = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
   }
}

resource "aws_instance" "tfdemo" {

    ami = "ami-60b6c60a"
    instance_type = "t2.micro"

   key_name = "neptune"
   security_groups = [ "ssh", "http", "default" ]

}
