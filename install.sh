# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------
# pull in customisations for bash (access to env vars and funcs)
source .bashrc_custom

# -----------------------------------------------------------------------------
# bash
# -----------------------------------------------------------------------------
echo "Backing up bashrc"
bu ~/.bashrc

echo "Checking if customisations will be recognised by existing bashrc"
add_customisations_cmd="source ~/.bashrc_custom"
if ! grep -q "$add_customisations_cmd" ~/.bashrc; then
    echo "Customisations not recognised, modifying bashrc"
    echo "$add_customisations_cmd" >> ~/.bashrc
fi

echo "Making symlink to bashrc customisations"
ln -srf .bashrc_custom ~/.bashrc_custom

# -----------------------------------------------------------------------------
# nvim
# -----------------------------------------------------------------------------
echo "Backing up existing nvim environment"
bu $VIMCONFIG
bu $VIMDATA

echo "Creating clean nvim environment"
rm -rf $VIMCONFIG
rm -rf $VIMDATA
mkdir $VIMCONFIG
mkdir $VIMDATA

echo "Making symlink to nvim config"
ln -srf init.vim $VIMCONFIG/init.vim

echo "Installing python packages for nvim"
# python3 provider
pip3 install --upgrade --user pynvim
# packages for ALE
pip3 install --upgrade --user flake8 isort yapf

echo "Installing system packages for nvim"
# shell check static analyser
if grep -iq fedora /etc/*release; then
    sudo dnf install ShellCheck
elif grep -iq ubuntu /etc/*release; then
    sudo apt install shellcheck
else
    echo "You aren't using Fedora or Ubuntu, so I don't know how to install
    the shellcheck package. Sorry!"
fi

echo "Installing minpac"
mkdir -p $VIMCONFIG/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git \
	$VIMCONFIG/pack/minpac/opt/minpac

echo "Installing nvim plugins"
nvim --headless +PackUpdateAndQuit

# -----------------------------------------------------------------------------
# tmux
# -----------------------------------------------------------------------------
echo "Backing up existing tmux config"
bu ~/.tmux.conf

echo "Making symlink to tmux config"
ln -srf .tmux.conf ~/.tmux.conf

# -----------------------------------------------------------------------------
# gitconfig
# -----------------------------------------------------------------------------
echo "Backing up existing gitconfig"
bu ~/.gitconfig

echo "Making symlink to gitconfig"
ln -srf .gitconfig ~/.gitconfig
