cd
git init
git remote add origin https://github.com/zoopyserg/ultrasonic-aliases.git
git fetch origin
git checkout -b main --track origin/main
echo 'source "~/.aliases.sh"' >> ~/.bashrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
