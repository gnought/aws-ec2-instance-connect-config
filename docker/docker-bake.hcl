target "default" {
  context         = "docker"
  contexts        = { project = "." }
  pull            = true
}
target "deb" {
  inherits   = ["default"]
  dockerfile = "ubuntu/Dockerfile"
  target     = "deb"
  output     = ["./out"]
}
target "rpm" {
  inherits   = ["default"]
  dockerfile = "generic/Dockerfile"
  target     = "rpm"
  output     = ["./out"]
}
