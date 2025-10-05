echo ""
echo "##########################"
echo "## ACTUALIZANDO SISTEMA ##"
echo "##########################"
echo ""

sudo apt update && sudo apt upgrade -y

echo ""
echo "#############################"
echo "## INSTALANDO DEPENDENCIAS ##"
echo "#############################"
echo ""

#Instalando extrepo para Librewolf
sudo apt install extrepo -y
sudo extrepo enable librewolf

#Instalando aplicaciones
sudo apt install kitty fastfetch lsd bat neovim zsh zsh-autosuggestions zsh-syntax-highlighting curl librewolf nomacs python3-venv npm wl-clipboard flatpak plasma-discover-backend-flatpak python-is-python3 htop lazygit ranger fd-find solaar gcc-12 libgcc-12-dev build-essential pkexec dkms gh ripgrep

#Instalando Brave
curl -fsS https://dl.brave.com/install.sh | sh

# Instalando tree-sitter CLI para neovim
sudo npm install -g tree-sitter-cli

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Instalando uv
curl -LsSf https://astral.sh/uv/install.sh | sh

echo ""
echo "#############################"
echo "## INSTALANDO DEPENDENCIAS ##"
echo "#############################"
echo ""

cp -r cambiar/fonts/Firacode /usr/local/share/fonts

echo ""
echo "#####################"
echo "## INSTALANDO NVIM ##"
echo "#####################"
echo ""

git clone https://github.com/Slifer4010/nvim.git ~/.config/nvim

echo ""
echo "#########################"
echo "## INSTALANDO ZSH SUDO ##"
echo "#########################"
echo ""

sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

echo ""
echo "#############################"
echo "## INSTALANDO POWERLEVEL10K##"
echo "#############################"
echo ""

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

echo ""
echo "########################"
echo "## DESINSTALANDO APPS ##"
echo "########################"
echo ""

sudo apt remove firefox-esr libreoffice-core
sudo apt autoremove -y

echo ""
echo "#########################"
echo "## CREANDO DIRECTORIOS ##"
echo "#########################"
echo ""

mkdir ~/Projects

echo ""
echo "#########################"
echo "## DIRECTORIOS CREADOS ##"
echo "#########################"
echo ""

echo ""
echo "######################"
echo "## CONFIG DUAL BOOT ##"
echo "######################"
echo ""

sudo timedatectl set-local-rtc 1
