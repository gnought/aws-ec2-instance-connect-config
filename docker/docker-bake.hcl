target "default" {
  context  = "docker"
  contexts = { project = "." }
  pull     = true
}
target "deb" {
  inherits        = ["default"]
  dockerfile      = "ubuntu/Dockerfile"
  no-cache-filter = ["test"]
  target          = "deb"
  output          = ["./out"]
}
target "rpm" {
  inherits        = ["default"]
  dockerfile      = "generic/Dockerfile"
  no-cache-filter = ["test"]
  target          = "rpm"
  output          = ["./out"]
}
