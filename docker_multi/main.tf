terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "images" {
  for_each = { for container in var.containers : container.image => container }
  name     = each.key
}

resource "docker_container" "containers" {
  for_each = { for container in var.containers : container.name => container }
  name     = each.value.name
  image    = docker_image.images[each.value.image].name

  dynamic "ports" {
    for_each = each.value.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }
}
