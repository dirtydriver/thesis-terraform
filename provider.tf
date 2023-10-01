terraform {
    required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.2.0"
    }
    }
}

variable "do_token" {
  
}

variable "pvt_key" {
  
}

variable "instance"{
  
}

provider "digitalocean" {
    token=var.do_token
}

data "digitalocean_ssh_key" "zenbook" {
  name="zenbook"
}