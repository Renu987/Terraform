resource "aws_vpc" "my_vpc" {
    name = "my_vpc"
    cidr = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
    name = "public_subnet1"
    vpc_id = aws_vpc.my_vpc.id
    cidr = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
    name = "public_subnet2"
    vpc_id = aws_vpc.my_vpc.id
    cidr = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "my-igw" {
    name = "my-igw"
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "rt" {
    name = "rt"
    vpc_id = aws_vpc.my_vpc.id
    
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rtb" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "renu-sg" {
    name = "renu-sg"
    vpc_id = aws_vpc.my_vpc.id

       ingress {
         from_port        = 22
         to_port          = 22
         protocol         = "tcp"
         cidr_blocks      = ["0.0.0.0/0"]
    
  }
       ingress {
        description = "HTTP from VPC"
        from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

       egress {
         from_port        = 0
         to_port          = 0
         protocol         = "-1"
         cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

resource "aws_instance" "instance1" {
    name = "instance1"
    ami = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    vpc_id = aws_vpc.my_vpc.id
    subnet_id = aws_subnet.subnet1.id
    security_groups = aws_security_group.renu-sg.name
    user_data              = base64encode(file("userdata.sh"))


}

resource "aws_instance" "instance2" {
    name = "instance2"
    ami = "ami-085ad6ae776d8f09c"
    instance_type = "t2.micro"
    key_name  = "linux"
    vpc_id = aws_vpc.my_vpc.id
    subnet_id = aws_subnet.subnet2.id
    security_groups = aws_security_group.renu-sg.id
    user_data              = base64encode(file("userdata1.sh"))


}

resource "aws_s3" "my_bucket" {
   bucket = "renu-renu-24"

}

#create a app load balancer

resource "aws_lb" "test-lb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.renu-sg.id]
  subnets            = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "test-tg" {
  name     = "test-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "test1" {
  target_group_arn = aws_lb_target_group.test-tg.arn
  target_id        = aws_instance.instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "test2" {
  target_group_arn = aws_lb_target_group.test-tg.arn
  target_id        = aws_instance.instance2.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = 80
  protocol          = "HTTPS"
  
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-tg.arn
  }
}



