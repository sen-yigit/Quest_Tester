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
 
 
 
 ###HOW TO USE IT
 # 1) COPY THIS FILE TO SERVER
 # 2) nano install.sh 
 # 3) copy inside into the file
 # 4) sudo chmod 777 install.sh
 # 5) sudo ./install.sh
 # 6) control-c to close the server first
 # 7) sudo docker start docker_questdb
 # 8) git clone https://github.com/sen-yigit/TEMGData
 # 9) IT MIGHT FREEZE AT POINT, IF IT FREEZES, control c when you see Filtering content:  94% (17/18) (OR JUST WAIT!)
 # 10) IF IT FREEZES, control-c and then git checkout -f HEAD
 # 11) ONCE IT'S DONE
 #     cd TEMGData
 #     nano ingressTest.sh
 #     copy the ingresstest file into the file
 #     sudo chmod 777 ingressTest.sh
 #     ./ingressTest.sh
 #     SAVE THE OUTPUT
 # 12) AT THE CLIENT 
 #     CLONE THIS PACKAGE
 #     cd Quest_Tester
 #     mvn package
 #     EDIT .env FILE - ONLY EDIT THE IP ADDRESS AND THE NUMBER OF TESTS, DO NOT TOUCH THE REST OF THE LINK!
 #     java -cp target/QuestTester-1.0-SNAPSHOT.jar QuestDBTester
 #     THERE SHOULD BE A CSV FILE PRINTING OUT (FIRST TEST THIS WITH NUM TESTS = 1
 
