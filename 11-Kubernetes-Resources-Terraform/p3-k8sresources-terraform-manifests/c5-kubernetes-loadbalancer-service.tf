# Kubernetes Service Manifest (Type: Load Balancer)
resource "kubernetes_service_v1" "lb_service" {
  metadata {
    name = "myapp1-lb-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp1.spec.0.selector.0.match_labels.app 
      # we dynamically referenced the pod label from the deployment resource
      # we could have also directly hardcoded the label value
      # spec.0 references the first block under the spec section which in this case is the selector block 
      # selector.o references the first block under the selector section which in this case is the match_labels block 
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

# Terraform Outputs
# in the reality we can get path of the value onces the resource is created
output "myapp1_loadbalancer_ip" {
  value = kubernetes_service_v1.lb_service.status[0].load_balancer[0].ingress[0].ip
}