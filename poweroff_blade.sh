#!/bin/bash

if [ -z "$1" ]; then
echo "В виде параметра не задано имя сервера"
exit 1
else
    #Проверка доступности сервера по ssh
    for (( nb = 1; nb < 11; nb++ )) #Цикл по всем лезвиям
    do
	if [ $nb -ne 10 ]; then #Если лезвие не 10-ое, то добавляем ноль в DNS имя сервера
	    sn=$1'b0'$nb
	else
	    sn=$1'b'$nb
	fi
	state_os=`sudo nc $sn 22 -w 1 | wc -l` #Проверка доступности сервера по ssh
	if [ $state_os -eq 1 ]; then #Если сервер доступен по SSH, проверяем какая операционная система на нем установлена.
	    state_virt=`sudo ssh $sn -o "StrictHostkeyChecking=no" ps aux | grep [l]ibvirt | wc -l`
	    if [ $state_virt -ne 0 ]; then #0 - Libvirt не запущен или запущено несколько
		echo "Завршение работы виртуальных машин на сервере "$sn
		for i in $(sudo virsh --connect qemu+ssh://root@$sn/system list | sed '1,2d' | awk '{print$2}'); do #Убивает все запущенные виртуалки запущенные на хосте
		    `sudo virsh --connect qemu+ssh://root@$sn/system destroy $i`
		done
	    fi
	    echo "Завершение работы сервера "$sn
	    `sudo ssh $sn poweroff`
	fi
    done
fi
