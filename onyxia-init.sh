curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g yarn
code-server --install-extension vscodevim.vim
code-server --install-extension vscode-icons-team.vscode-icons

git clone https://github.com/garronej/working_environnement && cd working_environnement && sudo ./apply.sh && source ~/.bashrc


cd /home/coder/work/covid19-dashboard
yarn
