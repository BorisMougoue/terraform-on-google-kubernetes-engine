# Resource: Horizontal Pod Autoscaler V2
resource "kubernetes_horizontal_pod_autoscaler_v2" "cpu_autoscaler" {
  metadata {
    name = "myapp1-hpa" 
  }

  spec {
    min_replicas = 1
    max_replicas = 10
   # we are enabling HPA for the deployment resource
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = kubernetes_deployment_v1.myapp1.metadata[0].name # [0] refers to the first block
    }
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 30
        }
      }
    }
  }
}
