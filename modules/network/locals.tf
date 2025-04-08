locals {
  public_subnet_names  = [for i in range(1, 3) : format("zeyad-s-public-subnet-%d", i)]
  private_subnet_names = [for i in range(1, 3) : format("zeyad-s-private-subnet-%d", i)]
}
