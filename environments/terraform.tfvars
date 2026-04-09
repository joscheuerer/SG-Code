region = "eastus"

subnets = {
  akssubnet = {
    address_prefix = "10.0.1.0/24"
  }
  appsubnet = {
    address_prefix = "10.0.2.0/24"
  }
  dbsubnet = {
    address_prefix = "10.0.3.0/24"
  }
}