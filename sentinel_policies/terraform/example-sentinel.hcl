module "tfplan-functions" {
  source = "https://raw.githubusercontent.com/hashicorp/terraform-guides/master/governance/third-generation/common-functions/tfplan-functions/tfplan-functions.sentinel"
}

policy "allowed-providers" {
    source = "./allowed-providers.sentinel"
    enforcement_level = "advisory"
}

policy "allowed-datasources" {
    source = "./allowed-datasources.sentinel"
    enforcement_level = "advisory"
}

policy "prohibited-provisioners" {
    source = "./prohibited-provisioners.sentinel"
    enforcement_level = "advisory"
}

policy "prohibited-resources" {
    source = "./prohibited-resources.sentinel"
    enforcement_level = "advisory"
}

policy "require-all-resources-from-pmr" {
    source = "./require-all-resources-from-pmr.sentinel"
    enforcement_level = "advisory"
}
