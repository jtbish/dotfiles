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
# editorconfig
# -----------------------------------------------------------------------------
echo "Backing up existing editorconfig"
bu ~/.editorconfig

echo "Making symlink to editorconfig"
ln -srf .editorconfig ~/.editorconfig
