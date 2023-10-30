terraform {
    required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.3.0"
    }
      }

    backend "artifactory" {
      # URL of the nexus repository
      url      = "https://nexus.thepetruska.com/repository/" 
      # the repository name you just created
      repo     = "raw_files" 
      # an unique path to for identification
      subpath  = "terraform"
     
      }   
}