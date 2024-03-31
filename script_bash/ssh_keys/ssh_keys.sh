StrictHostKeyChecking=no#!/bin/bash

if [ -z "$1" ]; then
    echo "В качастве параметра требуется передеать имя сервера (Например: srva01)"
    exit 1
else
    for (( bn = 1; bn < 11; bn++ )) #Цикл по всем лезвиям
    do
	if [ $bn -ne 10 ]; then #Если лезвие не 10-ое, то добавляем ноль в DNS имя сервера
	    snf=$1'b0'$bn
        else
	    snf=$1'b'$bn
	fi
    echo "Добавление ключей на сервер $snf"
    ssh-copy-id $snf -o "StrictHostKeyChecking=no"
    #параметр отключающий проверку ключа ssh
    done
fi
