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

# Instalando extrepo para Librewolf
sudo apt install extrepo -y
sudo extrepo enable librewolf

# Instalando aplicaciones
sudo apt install -y kitty fastfetch lsd bat neovim zsh zsh-autosuggestions zsh-syntax-highlighting curl librewolf nomacs python3-venv npm wl-clipboard flatpak plasma-discover-backend-flatpak python-is-python3 htop lazygit ranger fd-find solaar gcc-12 libgcc-12-dev gh ripgrep plymouth-themes kde-config-plymouth

# Instalando Brave
curl -fsS https://dl.brave.com/install.sh | sh

# Instalando tree-sitter CLI para neovim
sudo npm install -g tree-sitter-cli

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Instalando uv
curl -LsSf https://astral.sh/uv/install.sh | sh

echo ""
echo "#########################"
echo "## CREANDO DIRECTORIOS ##"
echo "#########################"
echo ""

mkdir ~/Projects

ruta=$(pwd)

echo ""
echo "####################"
echo "## INSTALANDO ZSH ##"
echo "####################"
echo ""

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Copiando zsh y p10k
rm -rf ~/.zshrc
rm -rf ~/.p10k.zsh
cp $ruta/.zshrc ~/.zshrc
cp $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp $ruta/.p10k.zsh-root /root/.p10k.zsh
sudo ln -sf ~/.zshrc /root/.zshrc

# Plugins zsh
sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambio a zsh
chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root

echo ""
echo "########################"
echo "## INSTALANDO FUENTES ##"
echo "########################"
echo ""

sudo cp -r $ruta/fonts/Firacode /usr/local/share/fonts

echo ""
echo "##################"
echo "## CONFIG KITTY ##"
echo "##################"
echo ""

cp -r $ruta/kitty ~/.config/kitty

echo ""
echo "#####################"
echo "## INSTALANDO NVIM ##"
echo "#####################"
echo ""

git clone https://github.com/Slifer4010/nvim.git ~/.config/nvim

echo ""
echo "########################"
echo "## DESINSTALANDO APPS ##"
echo "########################"
echo ""

sudo apt remove firefox-esr libreoffice-core
sudo apt autoremove -y

echo ""
echo "######################"
echo "## CONFIG DUAL BOOT ##"
echo "######################"
echo ""

sudo timedatectl set-local-rtc 1

sudo rm -r ~/borrar
notify-send -i dialog-information "Instalación terminada" "Todo listo"
