yum install -y epel-release
yum update -y
yum -y install $(cat list.txt)

#configure
git config --global credential.helper store
