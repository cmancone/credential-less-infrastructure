locals {
  name = "${var.name}-gateway"
  tags = merge(var.tags, { Name = "${var.name}-gateway" })
}
