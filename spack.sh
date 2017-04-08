#!/bin/bash

m="\033[1;31m"
k="\033[1;33m"
h="\033[1;32m"
b="\033[1;34m"
n="\033[1;0m"

spack_confirm(){
	echo -n "[!] Do You Want back to menu ? [Y/n]"
	read sbtm
	if [[ $btm == "y" || $btm == "Y" || $btm == "" ]]; then
		spack_main
	else
		clear
		echo "[+] Byee... :*"
		echo "[+] Good Luck, have Nice Day!"
	fi
}
spack_koneksi(){
echo "[+] Checking internet Connection ..."
wget -q --tries=10 --timeout=20 --spider https://google.com
if [[ $? -eq 0 ]]; then
echo -e $h"[+] Connection Estabilished ~"$n
sleep 2
else
echo -e $m"[-] No internet Connection Or Your internet to slow .."$n
sleep 3
spack_confirm
fi
}
spack_load(){
clear
echo "[|] SPACK ."
sleep 0.3 ; clear
echo "[/] Spack .."
sleep 0.3 ; clear
echo "[-] sPack ..."
sleep 0.3 ; clear
echo "[\] spAck ...."
sleep 0.3 ; clear
echo "[|] spaCk ....."
sleep 0.3 ; clear
echo "[/] spacK ......"
sleep 0.3 ; clear
echo "[-] spack ......."
sleep 0.3 ; clear
}
spack_cekgammu(){
	clear
	echo "[!] Checking Gammu Installed ..."
	sleep 0.4
	which gammu > /dev/null 2>&1
	if [[ $? -eq 0 ]]; then
		echo -e $h"[!]$n Gammu Installed OK!"
	else
		echo -e $m"[-]$n Gammu Not Installed :( "
		spack_confirm
	fi
}
spack_gammu_install(){
spack_load
spack_load
sleep 2
spack_koneksi
echo -n "[+] Do you want update system [Y/n] "
read iu
if [[ $iu == "y" || $iu == "Y" || $iu == "" ]]; then
	echo "[!] Updating ...."
	apt-get update -y
else
	echo "[!] Continue install without update ..."
	sleep 0.3
fi
echo "[!] Installing Gammu & gammu-smsdrc Please wait ..."
apt-get install gammu gammu-smsd -y
spack_confirm
}

spack_gammu_config(){
spack_cekgammu
sleep 1
gammu-config
spack_confirm
}
spack_gammu_service(){
	spack_cekgammu
	sleep 0.5
	/etc/init.d/gammu-smsd status > gammu_status.spack
	if [[ -f gammu_status.spack ]]; then
		cat gammu_status.spack | grep "running" > /dev/null
		if [[ $? -eq 0 ]]; then
			status_gm=$h"RUNNING"$n
		else
			status_gm=$m"STOPED !"$n
		fi
	fi
	spack_load
	sleep 0.4
	clear
	echo -e "[+] GAMMU-SMSD STATUS :"$status_gm
	echo -e "[+] if you want to change the status of the service gammu?"
	echo -e -n "[R]Restart [S]Start [RL]Reload [ST]Stop [FR]Force Reload :"
	read gms
	if [[ $gms == "R" || $gms == "r" ]]; then
		/etc/init.d/gammu-smsd restart
	elif [[ $gms == "S" || $gms == "s" ]]; then
		/etc/init.d/gammu-smsd start
	elif [[ $gms == "RL" || $gms == "rl" ]]; then
		/etc/init.d/gammu-smsd reload
	elif [[ $gms == "ST" || $gms == "st" ]]; then
		/etc/init.d/gammu-smsd stop
	elif [[ $gms == "FR" || $gms == "fr" ]]; then
		/etc/init.d/gammu-smsd force-reload
	else
		spack_gammu_service
	fi
	spack_confirm
}
spack_smsdrc_config(){
	spack_cekgammu
	sleep 1
	spack_load
	sleep 0.4
	echo "[+] Checking /etc/gammu-smsdrc ..."
	dirconf="/etc/gammu-smsdrc"
	if [[ -f $dirconf ]]; then
		echo -e "[+] /etc/gammu-smsdrc$h Exists !!"$n
		sleep 0.6
		nano $dirconf
	else
		echo -e "[-] /etc/gammu-smsdrc$m Not Exists !!"$n
	fi
	spack_confirm
}
spack_detectmodem(){
dmesg | grep "tty" > modem_detect.spack
spack_load
cat modem_detect.spack | grep "ttyUSB0" > /dev/null
if [[ $? -eq 0 ]]; then
	echo -e $h"[+] MODEM DETECTED :$k ttyUSB0"$n
else
	cat modem_detect.spack | grep "ttyUSB1" > /dev/null
	if [[ $? -eq 0 ]]; then
		echo -e $h"[+] MODEM DETECTED :$k ttyUSB1"$n
	else
		cat modem_detect.spack | grep "ttyUSB2" > /dev/null
		if [[ $? -eq 0 ]]; then
			echo -e $h"[+] MODEM DETECTED :$k ttyUSB2"$n
		else
			cat modem_detect.spack | grep "ttyUSB3" > /dev/null
			if [[ $? -eq 0 ]]; then
				echo -e $h"[+] MODEM DETECTED :$k ttyUSB3"$n
			else
				echo "[+] Modem not detected in this program !"
				echo "[+] Check Modem Detect LOG -> \"modem_detect.spack\" ... "
			fi
		fi
	fi

fi

spack_confirm
}

spack_main(){
	clear
echo -e $m"   :'######::'"$k"########:::::'###:::::'######::'##:::'##:"$n
echo -e $m"   '##... ##: "$k"##.... ##:::'## ##:::'##... ##: ##::'##::"$n
echo -e $m"    ##:::..:: "$k"##:::: ##::'##:. ##:: ##:::..:: ##:'##:::"$n
echo -e $m"   . ######:: "$k"########::'##:::. ##: ##::::::: #####::::"$n
echo -e $m"   :..... ##: "$k"##.....::: #########: ##::::::: ##. ##:::"$n
echo -e $m"   '##::: ##: "$k"##:::::::: ##.... ##: ##::: ##: ##:. ##::"$n
echo -e $m"   . ######:: "$k"##:::::::: ##:::: ##:. ######:: ##::. ##:"$n
echo -e $h"   :......:::."$h".:::::::::..:::::..:::......:::..::::..::"$n
echo -e $n"+---=== [["$h" SMS Gateway Package With Gammu Service "$n"]] ===---+"
echo -e $n"+----==== [["$m"   BLC Telkom Klaten - KPLI Klaten "$n"]] =====----+"
echo -e $n"+-----===== [["$b"  @Alinko - @Yogi - @Ramdhani  "$n"]] ======-----+"
echo ""
echo ""
echo -e $n"["$m"01"$n"].$k Gammu Install"
echo -e $n"["$m"02"$n"].$k Gammu Config"
echo -e $n"["$m"03"$n"].$k Gammu Service"
echo -e $n"["$m"04"$n"].$k Smsdrc Config"
echo -e $n"["$m"05"$n"].$k Kalkun 0.7.1"
echo -e $n"["$m"06"$n"].$k S.A.G.A 2"
echo -e $n"["$m"07"$n"].$k Simorin 0.1 [Yogs]"
echo -e $n"["$m"10"$n"].$k Modem Detect !"
echo -n -e $m"spack"$k"@"$m"menu$n >>"
read spack_menu
if [[ $spack_menu == "01" || $spack_menu == "1" ]]; then
	spack_gammu_install
elif [[ $spack_menu == "02" || $spack_menu == "2" ]]; then
	spack_gammu_config
elif [[ $spack_menu == "03" || $spack_menu == "3" ]]; then
	spack_gammu_service
elif [[ $spack_menu == "04" || $spack_menu == "4" ]]; then
	spack_smsdrc_config
elif [[ $spack_menu == "07" || $spack_menu == "7" ]]; then
	spack_simorin
elif [[ $spack_menu == "10" ]]; then
	spack_detectmodem
else
	spack_main
fi
}
root=`id -u`
if [[ $root != "0" ]]; then
	echo "[!] You Must Be root. "
else
	spack_main
fi
