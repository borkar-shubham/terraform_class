output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "pub_sub_ids" {
  value = aws_subnet.pub_sub.*.id #["${aws_subnet.tf_vpc_pub_sub.*.id}"]
}
output "pvt_sub_ids" {
  value = aws_subnet.pvt_sub.*.id
}
output "security_group_id" {
  value = aws_security_group.myvpc_sg.id
}