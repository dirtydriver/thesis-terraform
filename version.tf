terraform {
    required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.3.0"
    }
    }    
    backend "artifactory" {}
}