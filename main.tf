data "ovh_cloud_project_kube_nodepool" "cloud_project_kube_nodepool_lookup" {
  for_each = var.cloud_project_kube_nodepool_lookup

  kube_id            = each.value.kube_id
  name               = each.value.name
  service_name       = each.value.service_name
  availability_zones = each.value.availability_zones

  dynamic "attach_floating_ips" {
    for_each = each.value.attach_floating_ips != null ? [each.value.attach_floating_ips] : []
    content {
      enabled = attach_floating_ips.value.enabled
    }
  }

  dynamic "template" {
    for_each = each.value.template != null ? [each.value.template] : []
    content {
      dynamic "metadata" {
        for_each = template.value.metadata != null ? [template.value.metadata] : []
        content {
          annotations = metadata.value.annotations
          finalizers  = metadata.value.finalizers
          labels      = metadata.value.labels
        }
      }
      dynamic "spec" {
        for_each = template.value.spec != null ? [template.value.spec] : []
        content {
          taints        = spec.value.taints
          unschedulable = spec.value.unschedulable
        }
      }
    }
  }
}

