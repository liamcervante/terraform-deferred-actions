required_providers {
  tfcoremock = {
    source = "hashicorp/tfcoremock"
    version = "0.2.0"
  }
  time = {
    source = "hashicorp/time"
    version = "0.12.0"
  }
}

provider "tfcoremock" "self" {
    config {
        use_only_state = true
    }
}

provider "time" "self" {}

variable "strings" {
    type = set(string)
}

component "deferer" {
    source = "./component"

    providers = {
      tfcoremock = provider.tfcoremock.self
      time = provider.time.self
    }

    inputs = {
      strings = var.strings
      sleep = "1m"
    }
}

component "deferee" {
    source = "./component"

    providers = {
      tfcoremock = provider.tfcoremock.self
      time = provider.time.self
    }

    inputs = {
        strings = component.deferer.ids
        sleep = "0s"
    }
}
