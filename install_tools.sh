export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8

###############################################################################
# check os versio
os=$(cat /etc/os-release | grep PRETTY_NAME |  cut -d'"' -f2)

known_versions=("CentOS Linux 7 (Core)")

found=false

for known_version in "${known_versions[@]}"; do
        if [ "$os" == "$known_version" ]; then
            found=true
            break
        fi
done

if $found; then
        echo "Current OS version ($known_version) is in the list of supported OS."
    else
        echo "Current OS version ($known_version) is not in the list of not supported OS."
        exit 1
fi

####################################################################################""
if $os== "CentOS Linux 7 (Core)"; then
yum install -y -q  epel-release
yum update -y -q 
fi

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
user=outscale
runuser -l $user  -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions'

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting'

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search'

runuser -l $user  -c "sed -i 's/plugins=(git)/plugins=(history-substring-search zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc"

runuser -l $user  -c 'source ~/.zshrc'


