#install oh my zsh 
user=outscale 
runuser -l $user  -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions' 

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting'

runuser -l $user  -c 'ZSH_CUSTOM=/home/'"$user"'/.oh-my-zsh/custom && git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search'

runuser -l $user  -c "sed -i 's/plugins=(git)/plugins=(history-substring-search zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc"

runuser -l $user  -c 'source ~/.zshrc'

