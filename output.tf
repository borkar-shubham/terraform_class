# output "name" {
#   value = "My name is ${var.name}"
# }

# output "age" {
#   value = "My age is ${var.age}"
# }

# output "Marital_Status" {
#   value = "Is married? ${var.marital_status}"
# }

# output "fruits" {
#   value = "My favorite fruit is ${var.fruits[2]}"
# }

output "gender" {
  value = "My name is ${var.name} and my gender is ${lookup(var.gender, var.name)}"
}

