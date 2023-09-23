yum install -y epel-release
yum update -y
yum -y install $(cat install_tools_list.txt)
