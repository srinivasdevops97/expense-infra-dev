# In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so please visit https://aws.amazon.com/marketplace/pp?sku=f2ew2wrz425a1jagnifd02u5t
resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = file("~/.ssh/openvpn.pub")
}

module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  key_name = aws_key_pair.openvpn.key_name  
  # ami = data.aws_ami.joindevops.id
  ami = "ami-058fbc284998614e2"
  name = local.resource_name

  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpn_sg_id]
  subnet_id     = local.public_subnet_id

  # 👇 Prevents creation of a new SG
  create_security_group = false

  tags = merge(
    var.common_tags,
    var.vpn_tags,
    {
      Name = local.resource_name
    }
  )
}

