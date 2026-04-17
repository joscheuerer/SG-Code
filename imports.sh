#!/bin/sh
set -e

"$1" import -var-file environments/sg.tfvars 'module.vpc.aws_vpc.this' 'vpc-024344e8549773d40'
"$1" import -var-file environments/sg.tfvars 'module.subnet.aws_subnet.this' 'subnet-0b77c0d76befaf70d'
"$1" import -var-file environments/sg.tfvars 'module.security_group.aws_security_group.this' 'sg-04fe9eb743c23145a'
"$1" import -var-file environments/sg.tfvars 'module.ebs_volume.aws_ebs_volume.this' 'vol-0a8ceff639128dbb1'
"$1" import -var-file environments/sg.tfvars 'module.network_interface.aws_network_interface.this' 'eni-0d738514adbd9a62b'
"$1" import -var-file environments/sg.tfvars 'module.instance.aws_instance.this' 'i-02a92f89d43898403'