export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8

yum install -y -q  epel-release
yum update -y -q 

my_list="bind-utils
curl
dmidecode
fio
htop
iftop
iotop
lsof
mlocate
net-tools
nmap
nc
sysstat
tcpdump
telnet
traceroute
tree
unzip
vim-enhanced
wget
zsh
bc
git
screen
strace
python3.x86_64
python3-pip.noarch
socat
lsscsi"


# Split the string into an array using newline as the separator
IFS=$'\n' read -rd '' -a list_array <<< "$my_list"


for item in "${list_array[@]}"; do
     yum -y -q install $item
done

# make zsh default shell
chsh -s $(which zsh) 

#configure
git config --global credential.helper store

#install oh my zsh 

runuser -l outscale  -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

runuser -l outscale  -c 'git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions' 

runuser -l outscale  -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting'

runuser -l outscale  -c 'git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search'


