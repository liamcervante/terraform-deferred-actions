terraform {
  required_providers {
    tfcoremock = {
        source = "hashicorp/tfcoremock"
    }
    time = {
        source = "hashicorp/time"
    }
  }
}

variable "strings" {
    type = set(string)
}

variable "sleep" {
    type = string
}

resource "tfcoremock_simple_resource" "resource" {
    for_each = var.strings
    string = each.key
}

resource "time_sleep" "sleep" {
    create_duration = var.sleep
}

output "ids" {
    value = [ for r in tfcoremock_simple_resource.resource : r.id ]
}
