user="outscale"
alias=$(grep '#my_aliases'  /home/"$user"/.zshrc)
if [ !$alias ]; then
    echo '#my_aliases' >> /home/"$user"/.zshrc
    curl -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/maher-naija-pro/Best-Linux-Aliases/main/aliases.sh >>  /home/"$user"/.zshrc

fi 
