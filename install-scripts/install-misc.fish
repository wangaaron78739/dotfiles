#!/usr/bin/env fish

# make sure this is installed and use it for everything
# sudo apt install checkinstall
mkdir -p ~/git-builds
cd ~/git-builds

# nnn - not that, its a file manager
wget https://github.com/jarun/nnn/releases/download/v4.0/nnn_4.0-1_ubuntu20.04.amd64.deb -O /tmp/nnn.deb
sudo dpkg -i /tmp/nnn.deb
sudo apt install suckless-tools sxiv xdotool

# google benchmark
cd ~/git-builds
git clone https://github.com/google/benchmark.git --depth 1
cd benchmark
mkdir -p build && cd
cmake .. -DBENCHMARK_DOWNLOAD_DEPENDENCIES=ON -DBENCHMARK_ENABLE_GTEST_TESTS=OFF
ninja && sudo checkinstall ninja install

# fzf
cd ~/git-builds/
git clone https://github.com/junegunn/fzf.git
cd fzf
gvm use 16
make && checkinstall
sudo ln -s $PWD/bin/fzf ~/bin/fzf

# tikzit
cd ~/git-builds/
git clone https://github.com/tikzit/tikzit.git
sudo apt -y install flex bison qt5-default libpoppler-dev libpoppler-qt5-dev
cd tikzit
qmake -r
make

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch="(dpkg --print-architecture)" signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
