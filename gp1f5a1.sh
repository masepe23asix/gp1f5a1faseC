#!/bin/bash
ver=$(cat /var/lib/jenkins/workspace/gp1f5a1/desenvolupament/gp1f5a1/README | grep "Versió:" | cut -d " " -f 2)
echo $ver
ver_ant=$(cat /var/lib/jenkins/workspace/gp1f5a1/desenvolupament/gp1f5a1/README | grep "Versió anterior:" | cut -d " " -f 3)
echo $ver_ant
ssh vagrant@produccio mkdir -p projectes/gp1f5a1/$ver
scp -r /var/lib/jenkins/workspace/gp1f5a1/desenvolupament/gp1f5a1/ vagrant@produccio:~/projectes/gp1f5a1/$ver
if [[ ! -z $ver_ant ]]
then
        comprova=$(ssh vagrant@produccio ls /home/vagrant/projectes/gp1f5a1 | grep $ver_ant)
        if [[ $comprova != "" ]]
        then
                ssh vagrant@produccio docker-compose -f /home/vagrant/projectes/gp1f5a1/$ver_ant/gp1f5a1/docker-compose.yml down
        fi
fi
ssh vagrant@produccio docker-compose -f /home/vagrant/projectes/gp1f5a1/$ver/gp1f5a1/docker-compose.yml up -d
exit 0
