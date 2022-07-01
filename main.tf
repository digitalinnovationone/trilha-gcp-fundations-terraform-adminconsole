provider "googleworkspace" {
  credentials             = "${file("serviceaccount.yaml")}"
  customer_id             = "informaraqui"
  impersonated_user_email = "emailaqui"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
    "https://www.googleapis.com/auth/admin.directory.group",	
    # include scopes as needed
  ]
}

resource "googleworkspace_group" "devops" {
  email       = "devops@carlosbarbero.com.br"
  name        = "Devops"
  description = "Devops Group"

  aliases = ["dev-ops@carlosbarbero.com.br"]

  timeouts {
    create = "1m"
    update = "1m"
  }
}

resource "googleworkspace_user" "joao" {
  primary_email = "joao@carlosbarbero.com.br"
  password      = "34819d7beeabb9260a5c854bc85b3e44"
  hash_function = "MD5"

  name {
    family_name = "Joao"
    given_name  = "Ninguem"
  }
}

resource "googleworkspace_group_member" "manager" {
  group_id = googleworkspace_group.devops.id
  email    = googleworkspace_user.joao.primary_email

  role = "MANAGER"
}