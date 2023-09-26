###############################################################################
# check os versio
os=$(cat /etc/os-release | grep PRETTY_NAME |  cut -d'"' -f2)

known_versions=("Rocky Linux 9.2 (Blue Onyx)" "CentOS Linux 7 (Core)" "Rocky Linux 9.1 (Blue Onyx)" )

found=false

for known_version in "${known_versions[@]}"; do
        if [ "$os" = "$known_version" ]; then
            found=true
            break
        fi
done

if $found; then
        echo "Current OS version ($os) is in the list of supported OS."
    else
        echo "Current OS version ($os) is not in the list of not supported OS."
        exit 1
fi

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
####################################################################################""
if [ "$os" == "CentOS Linux 7 (Core)" ]; then
echo "Install epel releases"
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
tmux 
git
screen
strace
python3.x86_64
python3-pip.noarch
socat
lsscsi"


IFS=$'\n' read -rd '' -a list_array <<< "$my_list"

echo "Install basic package tools : it can take some minites please wait ..."
for item in "${list_array[@]}"; do
    sudo yum -y -q install $item
done


echo "Configure git"
#configure
git config --global credential.helper store


#install oh my zsh
echo "Install Oh-myzsh"
user=$(whoami)

rm -rf /home/"$user"/.oh-my-zsh/custom/plugins/zsh*


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install zsh-autosuggestions"

ZSH_CUSTOM=/home/"$user"/.oh-my-zsh/custom && git clone --quiet https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Install zsh-syntax-highlighting"


ZSH_CUSTOM=/home/"$user"/.oh-my-zsh/custom && git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "Install zsh-history-substring-search"

ZSH_CUSTOM=/home/"$user"/.oh-my-zsh/custom && git clone --quiet https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search

echo "Config zsh"
sed -i 's/plugins=(git)/plugins=(history-substring-search zsh-autosuggestions zsh-syntax-highlighting)/' /home/"$user"/.zshrc



# make zsh default shell
echo "set zsh for user"
sudo usermod --shell /usr/bin/zsh  outscale 

# install aliases
echo "install aliases"
alias=$(grep '#my_aliases'  /home/"$user"/.zshrc)
if [ "$alias" != "#my_aliases" ]; then
    echo '#my_aliases' >> /home/"$user"/.zshrc
    curl -s -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/maher-naija-pro/Best-Linux-Aliases/main/aliases.sh >>  /home/"$user"/.zshrc
fi

#Install vimrc 
curl -s -fLo /home/"$user"/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim=$(grep '"my_vim'  /home/"$user"/.vimrc)
rm -rf  /home/"$user"/.vimrc
if [ !$vim ]; then
    echo '"my_vim' >> /home/"$user"/.vimrc

    curl -s -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/maher-naija-pro/My-VimRC/main/.vimrc >>  /home/"$user"/.vimrc 
fi

#install theme 
git clone https://github.com/romkatv/powerlevel10k.git  /home/"$user"/.oh-my-zsh/themes/powerlevel10k 
sed -i "s/robbyrussell/powerlevel10k\/powerlevel10/g" /home/"$user"/.zshrc

echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> /home/"$user"/.zshrc


curl -s -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/maher-naija-pro/zsh_config/main/.p10k.zsh?token=GHSAT0AAAAAACHEHH57N2TX622RTGLMYLV2ZISZEJQ >>  /home/"$user"/.p10k.zsh

echo "###########################################################"
echo "###########################################################"
echo " ALL INSTALL SUCCESSFUL"
echo " Reconnect to your session "
echo "###########################################################"
echo "###########################################################"
