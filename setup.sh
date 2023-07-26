#!/bin/bash

######################
# Install Docker
######################

echo "Installing Docker..."

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $(whoami)
newgrp docker

echo "Installing Docker... Done"


######################
# Install Docker Compose
######################
echo "Installing Docker Compose..."
sudo apt-get install -y docker-compose
echo "Installing Docker Compose... Done"


######################
# Install Git
######################
echo "Installing Git..."
sudo apt-get install -y git
echo "Installing Git... Done"


######################
# Clone Repo
######################
git clone https://github.com/Musicminion/e5-toolkit.git ~/e5-toolkit

######################
# Change Directory
######################
cd ~/e5-toolkit
docker-compose pull

######################
echo "[Help] 接下来请执行的操作是："
echo "[1] 编辑 config.env 文件，命令：vim config.env 或者 nano config.env，退出方法是：按下 Esc 键，然后输入 :wq 回车(vim) / crtl+x Y回车(nano)"
echo "[2] 然后执行 docker-compose up -d，这个操作会启动所有的容器"
echo "[3] 安装Nginx，命令：sudo apt-get install -y nginx"
echo "[4] 编辑 nginx.conf 文件，然后覆盖到 /etc/nginx/nginx.conf，命令是：sudo vim /etc/nginx/nginx.conf 之后执行 sudo cp ~/e5-toolkit/nginx.conf /etc/nginx/nginx.conf"
echo "[5] 重启Nginx，命令：sudo systemctl restart nginx"
echo "如果你不知道如何编辑文件，请参考：https://www.runoob.com/linux/linux-vim.html"


