sudo apt update && sudo apt upgrade -y
# sudo apt install -y apt-transport-https  ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt update && sudo apt upgrade -y
sudo update-locale LANG=ja_JP.UTF-8
#sudo apt install -y docker-ce docker-compose
#sudo apt remove -y docker-compose
sudo apt install -y language-pack-ja manpages-ja
sudo apt install -y build-essential fontconfig zip multimo python3-pip python-pip
sudo apt install -y curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev gettext

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.profile
sudo mkdir -p /home/linuxbrew/.linuxbrew/var/homebrew/linked
sudo chown -R $(whoami) /home/linuxbrew/.linuxbrew/var/homebrew/linked
echo 'umask 002' >> ~/.bash_profile

sudo apt remove -y tmux byobu git
brew install tmux byobu fish git peco ghq hub zsh colordiff cmigemo ripgrep font-hack-nerd-font ruby source-highlight lsd
sudo sh -c "echo /home/linuxbrew/.linuxbrew/bin/fish >> /etc/shells"
chsh -s /home/linuxbrew/.linuxbrew/bin/fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher add oh-my-fish/plugin-peco

pip3 install powerline-status

# zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p /home/tatooear/.local/share/fonts
mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
mkdir -p  ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

#docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

wget -O /bin/pgrepper https://raw.githubusercontent.com/rubikitch/pgrepper/master/pgrepper
chmod +x /bin/pgrepper