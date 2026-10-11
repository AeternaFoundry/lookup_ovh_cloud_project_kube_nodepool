variable "cloud_project_kube_nodepool_lookup" {
  description = <<EOT
Map of cloud_project_kube_nodepool_lookup, attributes below
Required:
    - kube_id
    - name
    - service_name
Optional:
    - availability_zones
    - attach_floating_ips (block):
        - enabled (optional)
    - template (block):
        - metadata (optional, block):
            - annotations (optional)
            - finalizers (optional)
            - labels (optional)
        - spec (optional, block):
            - taints (optional)
            - unschedulable (optional)
EOT

  type = map(object({
    kube_id            = string
    name               = string
    service_name       = string
    availability_zones = optional(list(string))
    attach_floating_ips = optional(object({
      enabled = optional(bool)
    }))
    template = optional(object({
      metadata = optional(object({
        annotations = optional(map(string))
        finalizers  = optional(list(string))
        labels      = optional(map(string))
      }))
      spec = optional(object({
        taints        = optional(list(any))
        unschedulable = optional(bool)
      }))
    }))
  }))
}

