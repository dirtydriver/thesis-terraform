 data "terraform_remote_state" "nexus" {
    backend "artifactory" {
        # URL of the nexus repository
        url      = "https://nexus.thepetruska.com/repository/" 
        # the repository name you just created
        repo     = "raw_files" 
        # an unique path to for identification
        subpath  = "terraform"
        # an username that has permissions to the repository
        username = "${var.backend_user}"
        # the password of the username you provided
        password = "${var.backend_password}"
        }
 }