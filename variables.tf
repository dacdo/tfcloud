variable "env" { default = "dev" }
variable "inst_type" {
  type = map(string)
  default = {
  dev = "t2.micro"
  test = "t2.medium"
  prod = "t2.large"
  }
}
