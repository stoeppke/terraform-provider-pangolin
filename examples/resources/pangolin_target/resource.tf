resource "pangolin_target" "example" {
  resource_id = pangolin_resource.example.id
  site_id     = pangolin_site.example.id
  ip          = "192.168.1.10"
  port        = 8080
  method      = "http"
}

# Target with an active HTTP health check.
resource "pangolin_target" "healthchecked" {
  resource_id = pangolin_resource.example.id
  site_id     = pangolin_site.example.id
  ip          = "192.168.1.11"
  port        = 8080
  method      = "http"

  hc_enabled             = true
  hc_path                = "/health"
  hc_method              = "GET"
  hc_status              = 200
  hc_interval            = 30
  hc_unhealthy_interval  = 10
  hc_timeout             = 5
  hc_healthy_threshold   = 2
  hc_unhealthy_threshold = 3

  hc_headers = [
    { name = "X-Probe", value = "pangolin" },
  ]
}

# Target for a raw TCP/UDP resource — no HTTP scheme applies.
# method must be "" here: an unset value always means "give me the http
# default", so this is the only way to request no method on a new target.
# Importing an existing raw target needs neither set by hand — both come
# through correctly from the API (mode = "tcp", method = null).
resource "pangolin_target" "raw_tcp" {
  resource_id = pangolin_resource.ssh_backend.id
  site_id     = pangolin_site.example.id
  ip          = "192.168.1.12"
  port        = 22
  mode        = "tcp"
  method      = ""
}
