job "concourse-cicd-poc" {
  datacenters = ["dc1"]
  type = "service"

  update {
    stagger = "10s"
    max_parallel = 1
  }

  group "test" {
    count = 1
    ephemeral_disk {
      size = 32
    }
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    task "poc-server" {
      driver = "docker"
      config {
        image = "thecase/concourse-cicd-poc:latest"
        port_map { http = 3000 }
      }

      service { # consul service checks
        name = "poc-server"
        tags = ["http"]
        port = "http"
        check {
          type     = "http"
          interval = "10s"
          timeout  = "2s"
          path = "/"
        }
      }

      resources {
        cpu    = 512 # MHz 
        memory = 512 # MB 
        network {
          mbits = 10
          port "http" {}
        }
      }

      logs {
        max_files     = 3
        max_file_size = 2
      }
    }
  }
}
