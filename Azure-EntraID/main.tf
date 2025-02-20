data "azuread_domains" "aad" {
  only_initial = true
}

locals {
  domain_name = data.azuread_domains.aad.domains.*.domain_name
  users = csvdecode(file("users.csv")) //to convert csv file to a map
}

//create azure AD users
resource "azuread_user" "users" {
  for_each = { for user in local.users: user.first_name => user }
  
  //giving a principal name for the user
  user_principal_name = format("%s%s@%s",
  substr(each.value.first_name,0,1),
  lower(each.value.last_name),
  local.domain_name)

  //generating a password for the user
  password = format("%s%s%s!",
  lower(each.value.last_name),
  substr(lower(each.value.first_name),0,1),
  length(each.value.first_name)
  )

  display_name = "${each.value.first_name} ${each.value.last_name}"
  force_password_change = true
  department = each.value.department
  job_title = each.value.job_title


}


output "domain" {
  //* indicates all domains available in the domain list. If need to access a particular domain, then domain[index_value] can be used
  value = local.domain_name
}

output "username" {
  //since there are multiple values in map, we are iterating
  value = [for user in local.users : "${user.first_name} ${user.last_name}"]
}