job awesome-react-native {
  datacenters = ["dc1"]

  group awesome-react-native {
    count = 1
    task awesome-react-native {
      vault {
        policies = ["blockchainr-read-secrets"]
      }
      driver = "docker"
      config {
        image = "acrbc001.azurecr.io/awesome-react-native:latest"
        port_map {
          http = 3000
        }
      }
      template {
        data        = <<EOH
          PORT=3000
        EOH
        destination = "secrets/file.env"
        env         = true
      }
  
      resources {
        cpu    = 512
        memory = 1024
        network {
          port "http" {}
          mbits = 10
        }
      }
      service {
        name = "awesome-react-native"
        tags = [
          "api",
          "urlprefix-awesome-react-native-master.blockchainr.app/"
        ]
        port = "http"
        check {
          name = "alive"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }

}