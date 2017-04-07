#
# Provider, localhost by default
#
provider "docker" { }

#
# Container defintions, similar to my multi docker vagrant example.
#
resource "docker_container" "server1" {
   name  = "server1"
   image = "nginx:latest"
   ports = {
      internal = "80"
      external = "8000"
   }
}

resource "docker_container" "server2" {
   name  = "server2"
   image = "tomcat:latest"
   ports = {
      internal = "8080"
      external = "8080"
   }
}
