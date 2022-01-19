sudo apt-get update
sudo apt-get install \
   ca-certificates \
   curl \
   gnupg \
   lsb-release -y
sudo apt-get install git-lfs -y
git lfs install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
     "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   Install
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "------------THE IP ADDRESS OF THE MACHINE IS------------" && dig +short myip.opendns.com @resolver1.opendns.com
sudo docker run -p 9000:9000 \
  -p 9009:9009 \
  -p 8812:8812 \
  -p 9003:9003 \
  --name docker_questdb \
  questdb/questdb

 # bring the container up
 # sudo docker start docker_questdb
 # shut the container down
 # sudo docker stop docker_questdb
 # git clone https://github.com/sen-yigit/TEMGData
