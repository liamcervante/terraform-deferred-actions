terraform {
  required_providers {
    tfcoremock = {
        source = "hashicorp/tfcoremock"
    }
  }
}

variable "strings" {
    type = set(string)
}

resource "tfcoremock_simple_resource" "resource" {
    for_each = var.strings
    string = each.key
}

output "ids" {
    value = [ for r in tfcoremock_simple_resource.resource : r.id ]
}
