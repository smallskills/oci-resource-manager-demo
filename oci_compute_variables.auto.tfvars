#COMPUTE INSTANCE
compartment_id              = "ocid1.compartment.oc1..aaaaaaaayzlmguduqxdqdheajknimdeko6clkjtxvoxrewijoytq432yn2na"
compute_shape               = "VM.Standard.E2.1.Micro"
compute_name                = "TERRAFORM-01"
compute_subnet_id           = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaa7dkq4eisxpx7eswxnbzqyeevumy6ugxi7bpmwbk224v7wizx54dq"
compute_image_id            = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaasrq2nfjjeytzu64vb5frs25w3ynnmsmq7d3cr3kr53bsqhjxpeyq"
compute_ssh_authorized_keys = "./root-terraform.pub"

#NSG
compartment_nsg_id = "ocid1.compartment.oc1..aaaaaaaayzlmguduqxdqdheajknimdeko6clkjtxvoxrewijoytq432yn2na"
vcn_nsg_id = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaabiggidqaewwmohxrzx75jtc75o4kntz3hz4zuwdhq7vgb65zdqga"
security_groups_display_name = "NSG-TESTE"

#NSG RULE DIRECTION
rule_direction = "EGRESS"
rule_protocol = "all"
rule_destination = "10.80.0.0/17"
rule_destination_type = "CIDR_BLOCK"
rule_stateless = "false"
network_security_group_security_rule_description = "teste"
