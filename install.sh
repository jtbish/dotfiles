# -----------------------------------------------------------------------------
# bash
# -----------------------------------------------------------------------------
echo "Backing up bashrc..."
cp ~/.bashrc ~/.bashrc.backup

echo "Checking if customisations will be recognised by existing bashrc..."
add_customisations_cmd="source ~/.bashrc_customisations"
if ! grep -q "$add_customisations_cmd" ~/.bashrc; then
    echo "Customisations not recognised, modifying bashrc..."
    # append command to bashrc
    echo "$add_customisations_cmd" >> ~/.bashrc
fi

echo "Copying bashrc customisations..."
cp .bashrc_customisations ~/.bashrc_customisations

echo -e "\n"

# source new bashrc for env vars used in following nvim section
source ~/.bashrc

# -----------------------------------------------------------------------------
# nvim
# -----------------------------------------------------------------------------
echo "Backing up existing nvim environment..."
# remove old backups
rm -rf $VIMCONFIG.backup
rm -rf $VIMDATA.backup
# make new backups
cp -r $VIMCONFIG $VIMCONFIG.backup
cp -r $VIMDATA $VIMDATA.backup

echo "Creating clean nvim environment..."
rm -rf $VIMCONFIG
rm -rf $VIMDATA
mkdir $VIMCONFIG
mkdir $VIMDATA

echo "Copying nvim config into environment..."
cp init.vim $VIMCONFIG/init.vim

echo "Installing python packages for nvim..."
# python3 provider
pip3 install --upgrade pynvim
# packages for ALE
pip3 install --upgrade flake8 isort yapf

echo "Installing minpac..."
mkdir -p $VIMCONFIG/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git \
	$VIMCONFIG/pack/minpac/opt/minpac

echo "Installing plugins..."
nvim --headless +PackUpdateAndQuit

echo -e "\n"

# -----------------------------------------------------------------------------
# tmux
# -----------------------------------------------------------------------------
echo "Backing up existing tmux config..."
cp ~/.tmux.conf ~/.tmux.conf.backup

echo "Replacing existing tmux config..."
cp .tmux.conf ~/.tmux.conf

echo -e "\n"
