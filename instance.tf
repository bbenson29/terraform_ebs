resource "aws_instance" "catalyst" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "${var.subnet_id}"
    key_name = "mykey"
    tags {
      Name = "catalyst"
    }
    connection = {
      user = "ubuntu"
      private_key ="${file("${var.PATH_TO_PRIVATE_KEY}")}"
      timeout = "3m"

          }

}
resource "aws_key_pair" "mykeypair" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"

}

resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "${var.availability_zone}"
    size = 8
    type = "gp2"
    tags {
      Name = "volume for catalyst"
    }
  }
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
    device_name = "/dev/xvdf"
    volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
    instance_id = "${aws_instance.catalyst.id}"
    provisioner "file" {
      source = "volume.sh"
      destination = "/tmp/volume.sh"
      connection = {
        user = "ubuntu"
        private_key ="${file("${var.PATH_TO_PRIVATE_KEY}")}"
        host = "${aws_instance.catalyst.public_ip}"
      }
    }

    provisioner "remote-exec" {

      inline = [
        "sudo chmod +x /tmp/volume.sh",
         "sudo /tmp/volume.sh args"
       ]
       connection = {
         user = "ubuntu"
         private_key ="${file("${var.PATH_TO_PRIVATE_KEY}")}"
         host = "${aws_instance.catalyst.public_ip}"
     }
   }
 }
