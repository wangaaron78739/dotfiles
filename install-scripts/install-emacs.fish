#!/usr/bin/env fish

mkdir -p ~/git-builds
cd ~/git-builds
git clone --depth 1 git://git.savannah.gnu.org/emacs.git -b feature/native-comp
cd emacs
sudo apt install libxaw7-dev libgnutls30 xaw3dg xutils-dev libgnutls28-dev
./autogen.sh
./configure --with-native-compilation --with-modules --with-json --with-jpeg --with-png
make install -j(nproc)
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
sudo apt install libvterm-dev