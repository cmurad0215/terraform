variable "containers" {
  description = "List of container configurations"
  type = list(object({
    name    = string
    image   = string
    ports   = list(object({
      internal = number
      external = number
    }))
  }))
  default = [
    {
      name  = "nginx_container"
      image = "nginx:latest"
      ports = [
        {
          internal = 80
          external = 8080
        }
      ]
    },
    {
      name  = "redis_container"
      image = "redis:latest"
      ports = [
        {
          internal = 6379
          external = 6379
        }
      ]
    }
  ]
}
