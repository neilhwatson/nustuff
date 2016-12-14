# Configure the Docker provider

provider "docker" { }

data "docker_registry_image" "proxy" {
	name = "neilhwatson/proxy-watson-wilson.ca:latest"
}
data "docker_registry_image" "www" {
	name = "neilhwatson/www.watson-wilson.ca:latest"
}
data "docker_registry_image" "waves" {
	name = "neilhwatson/thewaves:latest"
}

resource "docker_container" "waves" {
	name  = "waves"
	image = "${docker_image.waves.latest}"
	ports = {
		internal = 3000
		external = 3000
	}
}

resource "docker_container" "proxy" {
	name  = "proxy"
	image = "${docker_image.proxy.latest}"
	ports = {
		internal = 80
		external = 80
	}
}

resource "docker_container" "www" {
	name  = "www"
	image = "${docker_image.www.latest}"
	ports = {
		internal = 80
		external = 31000
	}
}

resource "docker_image" "proxy" {
	name         = "${data.docker_registry_image.proxy.name}"
	pull_trigger = "${data.docker_registry_image.proxy.sha256_digest}"
}

resource "docker_image" "www" {
	name         = "${data.docker_registry_image.www.name}"
	pull_trigger = "${data.docker_registry_image.www.sha256_digest}"
}

resource "docker_image" "waves" {
	name         = "${data.docker_registry_image.waves.name}"
	pull_trigger = "${data.docker_registry_image.waves.sha256_digest}"
}
