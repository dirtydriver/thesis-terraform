variable "do_token" {
  
}

variable "pvt_key" {
  
}

variable "master"{
  
}

variable "worker"{
  
}

data "digitalocean_ssh_key" "zenbook" {
  name="zenbook"
}