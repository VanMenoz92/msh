#!/bin/bash

# CONFIGURARE IL LAYOUT DELLA TASTIERA ---> sudo dpkg-reconfigure keyboard-configuration
# RESTART DEL SERVIZIO TASTIERA ----------> sudo service keyboard-setup restart
# CONFIGURARE TIME ZONE ------------------> sudo dpkg-reconfigure tzdata
# SCARICA SCRIPT -------------------------> sudo curl https://raw.githubusercontent.com/VanMenoz92/msh/master/script/setup/01_setup.sh --output 01_setup.sh 1>/dev/null 2>/dev/null
# ABILITARE ESECUZIONE PER LO SCRIPT -----> sudo chmod 744 01_setup.sh
# ESEGUIRE LO SCRIPT ---------------------> sudo ./01_setup.sh
# ABILITARE SSH PER UTENTE ROOT ----------> sudo nano /etc/ssh/sshd_config (Rimuovere without-password dopo:  PermitRootLogin, Aggiungere yes dopo: PermitRootLogin)
# SE ROUTER AES
# ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
# update_config=1
#
# network={
#        ssid="Infostrada-EB3118"
#        psk="G7LLFX7R7G"
#        proto=RSN
#        key_mgmt=WPA-PSK
#        pairwise=CCMP
#        auth_alg=OPEN
# }

# CHECK WIFI
WIFI=false
if [ "$#" -ne 2 ]
	then
		echo "Non verra configurato il Wi-Fi"
	else
		echo "Verra configurato il Wi-Fi"
		WIFI=true
fi
# ABILITO WIFI
if [ "$WIFI" == true ]
	then
		echo "---------- CONFIGURAZIONE WIFI ----------"
		echo "Scrivo file delle interfacce di rete al path /etc/network/interfaces"
		sudo echo "auto lo

iface lo inet loopback
iface eth0 inet dhcp

auto wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" > /etc/network/interfaces
		sudo mkdir /etc/wpa_supplicant/
		echo "Scrivo file di configurazione per l'interfaccia wlan0 al path /etc/wpa_supplicant/wpa_supplicant.conf"
		sudo echo "ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
update_config=1

network={
        ssid=\"$1\"
        psk=\"$2\"
        proto=WPA
        key_mgmt=WPA-PSK
        pairwise=TKIP
        group=TKIP
        id_str=\"$1\"
}" > /etc/wpa_supplicant/wpa_supplicant.conf
# RESTART DEL SERVIZIO PER FARGLI LEGGERE LE CONFIGURAZIONI
		echo "Eseguo restart del servizio networking"
		sudo /etc/init.d/networking restart
fi
# CAMBIO PASSWORD
echo "---------- CAMBIO PASSWORD ----------"
echo "Eseguo cambio password dell'utente pi, vecchia password: raspberry"
passwd
# CAMBIO PASSWORD ROOT
echo "Eseguo cambio password dell'utente root"
sudo passwd root
echo "---------- UPDATE/INSTALLAZIONE PACCHETTI ----------"
# UPDATE
echo "Eseguo apt-get update"
sudo apt-get update -y 1>/dev/null 
# UPGRADE
echo "Eseguo apt-get upgrade"
sudo apt-get upgrade -y 1>/dev/null 
# APT-UTILS
echo "Eseguo apt-get install apt-utils"
sudo apt-get install apt-utils -y 1>/dev/null 
# PS, TOP, ecc..
echo "Eseguo apt-get install procps"
sudo apt-get install procps -y 1>/dev/null 
# NETSTAT
echo "Eseguo apt-get install net-tools"
sudo apt-get install net-tools -y 1>/dev/null 
# CURL
echo "Eseguo apt-get install curl"
sudo apt-get install curl -y 1>/dev/null 
# NMAP
echo "Eseguo apt-get install nmap"
sudo apt-get install nmap -y 1>/dev/null 
# AUTOSSH
echo "Eseguo apt-get install autossh"
sudo apt-get install autossh 1>/dev/null 
# SSH CLIENT
echo "Eseguo apt-get install ssh"
sudo apt-get install ssh -y 1>/dev/null 
# SSH SERVER
echo "Eseguo apt-get install openssh-server"
sudo apt-get install openssh-server -y 1>/dev/null 
sudo rm /etc/ssh/ssh_host_* 1>/dev/null 
echo "Eseguo dpkg-reconfigure openssh-server"
sudo dpkg-reconfigure openssh-server 1>/dev/null
echo "Eseguo service ssh start"
sudo service ssh start 1>/dev/null 
# WAKEONLAN
echo "Eseguo apt-get install wakeonlan"
sudo apt-get install wakeonlan -y 1>/dev/null 
# SAMBA per comando NET
echo "Eseguo apt-get install samba-common-bin"
sudo apt-get install samba-common-bin -y 1>/dev/null 
# CRON
echo "Eseguo apt-get install cron"
sudo apt-get install cron -y 1>/dev/null 
echo "Eseguo service cron start"
sudo service cron start 1>/dev/null 
# GACTIONS
echo "Eseguo download di gactions in /usr/bin/gactions"
sudo curl https://dl.google.com/gactions/updates/bin/linux/arm/gactions --output /usr/bin/gactions 1>/dev/null 2>/dev/null
echo "Assegno permessi di esecuzione a gactions"
sudo chmod +x /usr/bin/gactions 
# NPM
echo "Aggiungo repository per apt-get"
sudo curl -sL https://deb.nodesource.com/setup_9.x | sudo bash - 1>/dev/null 2>/dev/null
echo "Eseguo apt-get install nodejs"
sudo apt-get install nodejs -y 1>/dev/null
# UNZIP
echo "Eseguo apt-get install unzip"
sudo apt-get install unzip -y 1>/dev/null
echo "Eseguo apt-get install zip"
sudo apt-get install zip -y 1>/dev/null
# PS4-WAKER
echo "Scarico ps4-waker.zip"
sudo curl https://codeload.github.com/dhleong/ps4-waker/zip/master --output /usr/lib/ps4-waker.zip 1>/dev/null 2>/dev/null
cd /usr/lib
echo "Eseguo unzip ps4-waker.zip"
sudo unzip ps4-waker.zip 1>/dev/null 2>/dev/null
echo "Eseguo mv ps4-waker-master ps4-waker"
sudo mv ps4-waker-master ps4-waker
echo "Eseguo mv ps4-waker/lib ps4-waker/dist"
sudo mv ps4-waker/lib ps4-waker/dist
echo "Installo ps4-waker"
sudo npm i ps4-waker -g
echo "Rimuovo ps4-waker.zip"
sudo rm -rf ps4waker.zip
cd /home/pi
# PYTHON
echo "Eseguo apt-get install python3"
sudo apt-get install python3 -y 1>/dev/null 
echo "Eseguo apt-get install python3-pip"
sudo apt-get install python3-pip -y 1>/dev/null 
echo "Eseguo pip3 install webapp3"
sudo pip3 install --trusted-host pypi.python.org webapp3 1>/dev/null 
echo "Eseguo pip3 install paste"
sudo pip3 install --trusted-host pypi.python.org paste 1>/dev/null 
echo "Eseguo pip3 install pexpect"
sudo pip3 install --trusted-host pypi.python.org pexpect 1>/dev/null
echo "Eseguo pip3 install netifaces" 
sudo pip3 install --trusted-host pypi.python.org netifaces 1>/dev/null 
echo "Eseguo pip3 install python-crontab" 
sudo pip3 install --trusted-host pypi.python.org python-crontab 1>/dev/null
echo "Eseguo pip3 install fritzconnection"
sudo pip3 install --trusted-host pypi.python.org fritzconnection 1>/dev/null
echo "Eseguo pip3 install requests"
sudo pip3 install --trusted-host pypi.python.org requests 1>/dev/null
# SQLITE
echo "Eseguo apt-get install sqlite3 libsqlite3-dev"
sudo apt-get install sqlite3 libsqlite3-dev -y 1>/dev/null 
# SET CRON E SSH START ON REBOOT
echo "Imposto avvio servizio cron all'avvio"
sudo update-rc.d cron enable 1>/dev/null
echo "Imposto avvio servizio ssh all'avvio"
sudo update-rc.d ssh enable 1>/dev/null
# SCARICO E CONFIGURO ARDUINO-CLI
echo "Eseguo download di arduino-cli.tar.bz2"
sudo curl "https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-linuxarm.tar.bz2" --output arduino-cli.tar.bz2 1>/dev/null 2>/dev/null
echo "Decomprimo arduino-cli.tar.bz2"
sudo tar -xaf arduino-cli.tar.bz2 1>/dev/null
sudo rm -f arduino-cli.tar.bz2 1>/dev/null
echo "Sposto arduino-cli in /usr/bin/arduino-cli"
sudo mv arduino-cli-* /usr/bin/arduino-cli 1>/dev/null
echo "Creo configurazione per arduino-cli"
sudo su -c "arduino-cli config init 1>/dev/null"
sudo su -c "echo \"proxy_type: auto
sketchbook_path: /root/Arduino
arduino_data: /root/.arduino15
board_manager:
  additional_urls:
    - http://arduino.esp8266.com/stable/package_esp8266com_index.json\" >  /root/.arduino15/arduino-cli.yaml"
echo "Eseguo arduino-cli core update-index"
sudo arduino-cli core update-index 1>/dev/null
echo "Installo librerie Arduino per compilare"
echo "Install WiFi"
sudo arduino-cli lib install WiFi
echo "Install esp8266_mdns"
sudo arduino-cli lib install esp8266_mdns
echo "Install SimpleDHT"
sudo arduino-cli lib install SimpleDHT
echo "Install ArduinoJson"
sudo arduino-cli lib install ArduinoJson
# INSTALLAZIONE CORE SCHEDE
echo "Eseguo arduino-cli core install esp8266:esp8266"
sudo arduino-cli core install esp8266:esp8266 1>/dev/null
# AGGIUNGO 2 GB DI SWAP PER LA RAM
echo "---------- AGGIUNTA MEMORIA SWAP ----------"
echo "Modifico il file /etc/dphys-swapfile impostando dimensione partizione"
sudo echo "# where we want the swapfile to be, this is the default
#CONF_SWAPFILE=/var/swap

CONF_SWAPSIZE=2048

# set size to computed value, this times RAM size, dynamically adapts,
#   guarantees that there is enough swap without wasting disk space on excess
#CONF_SWAPFACTOR=2

#CONF_MAXSWAP=2048" > /etc/dphys-swapfile
echo "Restart servzio dphys-swapfile"
sudo /etc/init.d/dphys-swapfile restart 1>/dev/null
# SCARICO PAGEKITE
echo "Download di pagekite.py"
sudo curl https://pagekite.net/pk/pagekite.py --output server/pagekite.py 1>/dev/null 2>/dev/null
# SCARICO I SERVER
echo "Scarico server da GIT"
sudo curl https://codeload.github.com/VanMenoz92/msh/zip/master --output msh.zip 1>/dev/null 2>/dev/null
sudo unzip msh.zip 1>/dev/null
sudo mv msh-master/server . 1>/dev/null
sudo rm -rf msh-master 1>/dev/null
sudo rm -rf msh.zip 1>/dev/null
echo "---------- TO DO ----------"
echo "1) Accedere all'URL https://console.actions.google.com/ e creare un nuovo progetto"
echo "2) Accedere alla voce project settings e copiare il project ID"
echo "---------- LETTURA PARAMETRI ----------"
read -p "Inserire GOOGLE_PROJECT_ID: " GOOGLE_PROJECT_ID
read -p "Inserire inidrizzo e-mail per pagekite: " PAGEKITE_MAIL
read -p "Inserire un USERNAME per applicazione (es. simone): " USERNAME
read -p "Inserire la PASSWORD per l'utente $USERNAME: " PASSWORD
read -p "Inserire DOMINIO per l'OAUTH (es. oauthsimone): " OAUTH_DOMAIN
read -p "Inserire DOMINIO per l'applicazione (es. casasimone): " WEBAPP_DOMAIN
# CHECK SUL DOMINIO_OAUTH E DOMINIO_WEBAPP
echo "---------- CONTROLLO DOMINII ----------"
OAUTH=false
while [ "$OAUTH" == false ]
do
	echo "Verifico la disponibilita del dominio $OAUTH_DOMAIN"
	if curl -I -X GET https://$OAUTH_DOMAIN.serveo.net/ | grep "502 Bad Gateway"
	then
		echo "Dominio OAUTH disponibile"
		OAUTH=true
	else
		echo "Dominio OAUTH non disponibile"
		read -p "Inserire un nuovo dominio per OAUTH: " OAUTH_DOMAIN
	fi
done
WEBAPP=false
while [ "$WEBAPP" == false ]
do
	echo "Verifico la disponibilita del dominio $WEBAPP_DOMAIN"
	if curl -I -X GET https://$WEBAPP_DOMAIN.serveo.net/ | grep "502 Bad Gateway"
	then
		echo "Dominio WEBAPP disponibile"
		WEBAPP=true
	else
		echo "Dominio WEBAPP non disponibile"
		read -p "Inserire un nuovo dominio per la WEBAPP: " WEBAPP_DOMAIN
	fi
done
# RIMUOVO PRIMO SETUP
echo "Rimuovo vecchio setup"
sudo rm -rf 01_setup.sh
# CREO GACTIONS
echo "---------- CONFIGURAZIONE GACTIONS ----------"
echo "Creo file action.json"
sudo echo "{
	\"actions\": [{
			\"fulfillment\": {
				\"conversationName\": \"automation\"
			},
			\"name\": \"actions.devices\"
		}
	],
	\"conversations\": {
		\"automation\": {
			\"name\": \"automation\",
			\"url\": \"https://$WEBAPP_DOMAIN.serveo.net/api/home\"
		}
	},
	\"locale\": \"it\"
}" > action.json
echo "Eseguo update gactions"
OK=false
while [ "$OK" == false ]
do	
	if gactions update --action_package action.json --project $GOOGLE_PROJECT_ID
		then
			OK=true
	fi
done
sudo rm -f action.json 
sudo rm -f creds.data
# REGISTRAZIONE DOMINI SU PAGEKITE
cd server
echo "---------- CREAZIONE DOMINI PAGEKITE ----------"
echo "Creo dominio $WEBAPP_DOMAIN.pagekite.me"
echo $'Y\n'$PAGEKITE_MAIL$'\nY\nY' | sudo python pagekite.py 65177 $WEBAPP_DOMAIN.pagekite.me 2>/dev/null &
echo "Creo dominio oauth-$WEBAPP_DOMAIN.pagekite.me"
echo $'Y\nY' | sudo python pagekite.py 3000 oauth-$WEBAPP_DOMAIN.pagekite.me 1>/dev/null 2>/dev/null &
sudo pgrep python | awk '{print $0}' | xargs sudo kill -9 1>/dev/null 2>/dev/null
# DATABASE
echo "---------- CREAZIONE DATABASE ----------"
echo "Creo cartella per il database"
mkdir msh/db
echo "Scarico script di create"
sudo curl https://raw.githubusercontent.com/VanMenoz92/msh/master/script/setup/create.sql --output create.sql 1>/dev/null 2>/dev/null
echo "Eseguo script di create"
sudo sqlite3 ./msh/db/system.db < create.sql
echo "Creo script di insert"
sudo echo "INSERT INTO TB_USER (USERNAME, PASSWORD, ROLE) VALUES ('$USERNAME', '$PASSWORD', 'ADMIN');" > user.sql
echo "Eseguo script di insert"
sudo sqlite3 ./msh/db/system.db < user.sql
echo "Rimuovo script"
sudo rm -rf create.sql user.sql
# DEPLOY SH
echo "---------- CONFIGURAZIONE DEPLOY DA REMOTO ----------"
echo "Creo script deploy.sh"
sudo echo '#!/bin/bash

sudo curl https://codeload.github.com/VanMenoz92/msh/zip/master --output msh.zip
sudo curl https://raw.githubusercontent.com/VanMenoz92/msh/master/script/deploy/update_raspberry.sh --output update_raspberry.sh 1>/dev/null
sudo chmod 744 update_raspberry.sh
sudo unzip msh.zip 1>/dev/null
sudo mv msh-master/server/msh msh_tmp 1>/dev/null
sudo rm -rf msh-master 1>/dev/null
sudo rm -rf msh.zip 1>/dev/null
cd msh_tmp
sudo zip -r  ../msh.zip * 1>/dev/null
cd ..
sudo rm -rf msh_tmp  1>/dev/null
sudo ./update_raspberry.sh
sudo rm -rf update_raspberry.sh msh.zip
exit 0' > deploy.sh
echo "Assegno permessi di esecuzione allo script deploy.sh"
sudo chmod 744 deploy.sh
# SERVER OAUTH
echo "---------- CONFIGURAZIONE E INSTALLAZIONE SERVER OAUTH ----------"
cd oauth
echo "Creo script python per generazione token"
sudo echo "from string import ascii_letters, digits
from random import choice


def main():
    token = ''.join(choice(ascii_letters + digits) for i in range(36))
    f = open(\"token.txt\", \"w\")
    f.write(token)
    f.close()
    client_id = ''.join(choice(ascii_letters + digits) for i in range(32))
    f = open(\"clientid.txt\", \"w\")
    f.write(client_id)
    f.close()
    client_secret = ''.join(choice(ascii_letters + digits) for i in range(36))
    f = open(\"clientsecret.txt\", \"w\")
    f.write(client_secret)
    f.close()


if __name__ == '__main__':
    main()" > oauth.py
echo "Eseguo script python per generazione token"
sudo python3 oauth.py
token=`cat token.txt`
client_id=`cat clientid.txt`
client_secret=`cat clientsecret.txt`
echo "Rimuovo file temporanei"
sudo rm -f token.txt
sudo rm -f clientid.txt
sudo rm -f clientsecret.txt
sudo rm -f token.txt
sudo rm -f oauth.py
echo "Creo datastore.js"
sudo echo "const Data = {};

const Auth = {
  clients: {
    '$client_id': {
      clientId: '$client_id',
      clientSecret: '$client_secret'
    }
  },
  tokens: {
    '$token': {
      uid: '1',
      accessToken: '$token',
      refreshToken: '$token',
      userId: '1'
    }
  },
  users: {
    '1': {
      uid: '1',
      name: '$USERNAME',
      password: '$PASSWORD',
      tokens: ['$token']
    }
  },
  usernames: {
    '$USERNAME': '1'
  },
  authcodes: {}
};

Data.version = 0;

Data.getUid = function (uid) {
  return Data[uid];
};

/**
 * checks if user and auth exist and match
 *
 * @param uid
 * @param authToken
 * @returns {boolean}
 */
Data.isValidAuth = function (uid, authToken) {
  return (Data.getUid(uid));
};

exports.getUid = Data.getUid;
exports.isValidAuth = Data.isValidAuth;
exports.Auth = Auth;" > datastore.js
echo "Eseguo npm install"
sudo npm install 1>/dev/null 2>/dev/null
# SALVO PROJECT ID DI GOOGLE ACTIONS IN SETTINGS.XML
echo "---------- CREAZIONE SETTINGS.XML ----------"
echo "Creo settings.xml"
sudo echo "<settings>
	<lingua>IT</lingua>
	<ambiente>PROD</ambiente>
	<path_db>db/system.db</path_db>
	<path_datastore>../oauth/datastore.js</path_datastore>
	<timestamp>%Y-%m-%d %H:%M:%S</timestamp>
	<project_id_google_actions>$1</project_id_google_actions>
	<wifi_default>
	  <ssid></ssid>
	  <password></password>
	</wifi_default>
	<!-- n/s -->
	<net_on_google>n</net_on_google>
	<!-- n/s -->
	<wifi_on_google>n</wifi_on_google>
	<dns>
		<serveo>
			<!-- n/s -->
			<abil>n</abil>
			<test_url>http://serveo.net</test_url>
			<domain>.serveo.net</domain>
			<subdomain_oauth>$OAUTH_DOMAIN</subdomain_oauth>
			<subdomain_webapp>$WEBAPP_DOMAIN</subdomain_webapp>
		</serveo>
		<pagekite>
			<!-- n/s -->
			<abil>n</abil>
			<test_url>http://pagekite.net</test_url>
			<domain>.pagekite.me</domain>
			<subdomain_oauth>oauth-$WEBAPP_DOMAIN</subdomain_oauth>
			<subdomain_webapp>$WEBAPP_DOMAIN</subdomain_webapp>
		</pagekite>
	</dns>
	<log>
		<!-- Se valorizzato con None logga in console -->
		<filename>msh.log</filename>
		<format>%(asctime)s|%(levelname)s|%(filename)s:%(lineno)s|%(message)s</format>
		<!-- debug, info, warning, error, critical -->
		<level>info</level>
	</log>
</settings>" > ../msh/settings.xml
cd ../..
echo "---------- CREAZIONE SERVIZIO OAUTH ----------"
# SERVIZIO OAUTH
echo "Creo script oauth.sh"
sudo echo $'#!/bin/bash
### BEGIN INIT INFO
# Provides:          oauth
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Servizio OAUTH
# Description:       Servizio OAUTH
### END INIT INFO

command_start="cd /home/pi/server/oauth && sudo npm start 1>/dev/null 2>/dev/null &"
command_kill="ps -aux | grep node | grep server.js | awk \'{print \$2}\' | xargs sudo kill -9 1>/dev/null 2>/dev/null"
ret_check=`ps -aux | grep node | grep server.js`
case "$1" in
	check)
		if [ "$ret_check" != "" ]
			then
				echo "Attivo"
			else
				echo "Spento"
		fi
	;;
	start)
		if [ "$ret_check" != "" ]
			then
				echo "Servizio OAUTH attivo"
			else
				eval $command_start
				echo "Avviato servizio OAUTH"
		fi
	;;
	stop)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				echo "Stoppato servizio OAUTH"
			else
				echo "Servizio OAUTH non attivo"
		fi
	;;
	restart)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				eval $command_start
				echo "Restart servizio OAUTH"
			else
				eval $command_start
				echo "Avviato servizio OAUTH"
		fi
	;;
	*)
		echo "Usage: $0 {check|start|stop|restart}"
		exit 2
	;;
esac
exit 0' > oauth.sh
echo "Sposto script oauth.sh in /etc/init.d/oauth"
sudo mv oauth.sh /etc/init.d/oauth
echo "Assegno permessi di esecuzione a /etc/init.d/oauth"
sudo chmod +x /etc/init.d/oauth 1>/dev/null
# SERVIZIO PAGEKITE
echo "---------- CREAZIONE SERVIZIO PAGEKITE ----------"
echo "Creo script pagekite.sh"
sudo echo $'#!/bin/bash
### BEGIN INIT INFO
# Provides:          pagekite
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Servizio PAGEKITE
# Description:       Servizio PAGEKITE
### END INIT INFO

riga_pagekite=`cat /home/pi/server/msh/settings.xml | grep -n "<pagekite>" | awk \'{split($0, a, ":"); print a[1]}\'`
riga_oauth=`expr $riga_pagekite + 5`
riga_webapp=`expr $riga_oauth + 1`
oauth=`cat /home/pi/server/msh/settings.xml | head -n$riga_oauth | tail -n1 | cut -d\'>\' -f 2 | cut -d\'<\' -f 1`
webapp=`cat /home/pi/server/msh/settings.xml | head -n$riga_webapp | tail -n1 | cut -d\'>\' -f 2 | cut -d\'<\' -f 1`
command_start="cd /home/pi/server && sudo python pagekite.py $webapp.pagekite.me AND $oauth.pagekite.me 1>/dev/null 2>/dev/null &"
command_kill="ps -aux | grep pagekite.py | grep python | awk \'{print \$2}\' | xargs sudo kill -9 1>/dev/null 2>/dev/null"
ret_check=`ps -aux | grep pagekite.py | grep python`
case "$1" in
	check)
		if [ "$ret_check" != "" ]
			then
				echo "Attivo"
			else
				echo "Spento"
		fi
	;;
	start)
		if [ "$ret_check" != "" ]
			then
				echo "Servizio PAGEKITE attivo"
			else
				eval $command_start
				echo "Avviato servizio PAGEKITE"
		fi
	;;
	stop)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				echo "Stoppato servizio PAGEKITE"
			else
				echo "Servizio PAGEKITE non attivo"
		fi
	;;
	restart)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				eval $command_start
				echo "Restart servizio PAGEKITE"
			else
				eval $command_start
				echo "Avviato servizio PAGEKITE"
		fi
	;;
	*)
		echo "Usage: $0 {check|start|stop|restart}"
        exit 2
	;;
esac
exit 0' > pagekite.sh
echo "Sposto script pagekite.sh in /etc/init.d/pagekite"
sudo mv pagekite.sh /etc/init.d/pagekite
echo "Assegno permessi di esecuzione a /etc/init.d/pagekite"
sudo chmod +x /etc/init.d/pagekite 1>/dev/null
# SERVIZIO SERVEO
echo "---------- CREAZIONE SERVIZIO SERVEO ----------"
echo "Creo script serveo.sh"
sudo echo $'#!/bin/bash
### BEGIN INIT INFO
# Provides:          serveo
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Servizio SERVEO
# Description:       Servizio SERVEO
### END INIT INFO

riga_serveo=`cat /home/pi/server/msh/settings.xml | grep -n "<serveo>" | awk \'{split($0, a, ":"); print a[1]}\'`
riga_oauth=`expr $riga_serveo + 5`
riga_webapp=`expr $riga_oauth + 1`
oauth=`cat /home/pi/server/msh/settings.xml | head -n$riga_oauth | tail -n1 | cut -d\'>\' -f 2 | cut -d\'<\' -f 1`
webapp=`cat /home/pi/server/msh/settings.xml | head -n$riga_webapp | tail -n1 | cut -d\'>\' -f 2 | cut -d\'<\' -f 1`
command_start="autossh -M 0 -o \\"StrictHostKeyChecking no\\" -R $webapp:80:localhost:65177 -R $oauth:80:localhost:3000 serveo.net 1>/dev/null 2>/dev/null &"
command_kill="ps -aux | grep serveo | grep 65177 | awk \'{print \$2}\' | xargs sudo kill -9 1>/dev/null 2>/dev/null"
ret_check=`ps -aux | grep serveo | grep 65177`
case "$1" in
	check)
		if [ "$ret_check" != "" ]
			then
				echo "Attivo"
			else
				echo "Spento"
		fi
	;;
	start)
		if [ "$ret_check" != "" ]
			then
				echo "Servizio SERVEO attivo"
			else
				eval $command_start
				echo "Avviato servizio SERVEO"
		fi
	;;
	stop)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				echo "Stoppato servizio SERVEO"
			else
				echo "Servizio SERVEO non attivo"
		fi
	;;
	restart)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				eval $command_start
				echo "Restart servizio SERVEO"
			else
				eval $command_start
				echo "Avviato servizio SERVEO"
		fi
	;;
	*)
		echo "Usage: $0 {check|start|stop|restart}"
        exit 2
	;;
esac
exit 0' > serveo.sh
echo "Sposto script serveo.sh in /etc/init.d/serveo"
sudo mv serveo.sh /etc/init.d/serveo
echo "Assegno permessi di esecuzione a /etc/init.d/serveo"
sudo chmod +x /etc/init.d/serveo 1>/dev/null
# SERVIZIO MSH
echo "---------- CREAZIONE SERVIZIO MSH ----------"
echo "Creo script msh.sh"
sudo echo $'#!/bin/bash
### BEGIN INIT INFO
# Provides:          msh
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog  
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Servizio MSH
# Description:       Servizio MSH
### END INIT INFO

command_start="cd /home/pi/server/msh && sudo python3 msh.py 1>/dev/null 2>/dev/null &"
command_kill="ps -aux | grep msh.py | grep python | awk \'{print \$2}\' | xargs sudo kill -9 1>/dev/null 2>/dev/null"
ret_check=`ps -aux | grep msh.py | grep python`
case "$1" in
	check)
		if [ "$ret_check" != "" ]
			then
				echo "Attivo"
			else
				echo "Spento"
		fi
	;;
	start)
		if [ "$ret_check" != "" ]
			then
				echo "Servizio MSH attivo"
			else
				eval $command_start
				echo "Avviato servizio MSH"
		fi
	;;
	stop)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				echo "Stoppato servizio MSH"
			else
				echo "Servizio MSH non attivo"
		fi
	;;
	restart)
		if [ "$ret_check" != "" ]
			then
				eval $command_kill
				eval $command_start
				echo "Restart servizio MSH"
			else
				eval $command_start
				echo "Avviato servizio MSH"
		fi
	;;
	*)
		echo "Usage: $0 {check|start|stop|restart}"
        exit 2
	;;
esac
exit 0' > msh.sh
echo "Sposto script msh.sh in /etc/init.d/msh"
sudo mv msh.sh /etc/init.d/msh
echo "Assegno permessi di esecuzione a /etc/init.d/msh"
sudo chmod +x /etc/init.d/msh 1>/dev/null
echo "Imposto avvio servizio msh all'avvio"
sudo systemctl enable msh 1>/dev/null 2>/dev/null
echo "Eseguo service msh start"
sudo service msh start 1>/dev/null
# TEST
echo "---------- TEST INSTALLAZIONE ----------"
sleep 5
echo "Eseguo test per verificare esito installazione"
if curl -I -X GET http://127.0.0.1:65177/static/page/login.html | grep "200 OK"
then
	echo "INSTALLAZIONE RIUSCITA!!"
else
	echo "INSTALLAZIONE KO!!"
fi
echo "---------- TO DO ----------"
echo $'Accedere a Google Actions e impostare nella sezione Develop | Account Linking:
Account Creation -> NO
Linking Type: OAuth | Authorization Code
OAuth Client information:
	\tClient ID: '$client_id$'
	\tClient secret: '$client_secret$'
	\tAuthorization URL: https://'$OAUTH_DOMAIN$'.serveo.net/oauth
	\tToken URL: https://'$OAUTH_DOMAIN$'.serveo.net/token
Testing instructions: test

Se serveo dovesse smettere di funzionare:
1) Accedere a Google Actions e impostare nella sezione Develop | Actions:
	\tFulfillment: https://'$WEBAPP_DOMAIN$'.pagekite.me/api/home
2) Accedere a Google Actions e impostare nella sezione Develop | Account Linking:
OAuth Client information:
	\tAuthorization URL: https://oauth-'$WEBAPP_DOMAIN$'.pagekite.me/oauth
	\tToken URL: https://oauth-'$WEBAPP_DOMAIN$'.pagekite.me/token'
exit 0
