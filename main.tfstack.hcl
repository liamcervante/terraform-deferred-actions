required_providers {
  tfcoremock = {
    source = "hashicorp/tfcoremock"
    version = "0.2.0"
  }
}

provider "tfcoremock" "self" {
    config {
        use_only_state = true
    }
}

variable "strings" {
    type = set(string)
}

component "deferer" {
    source = "./component"

    providers = {
      tfcoremock = provider.tfcoremock.self
    }

    inputs = {
      strings = var.strings
    }
}

component "deferee" {
    source = "./component"

    providers = {
      tfcoremock = provider.tfcoremock.self
    }

    inputs = {
        strings = component.deferer.ids
    }
}
