#!/bin/bash

log_file=/admin_scripts_itc_uvo/virt_machines_stat.txt

test -f $log_file
if [[ $? -eq 0 ]]; then
    echo '' > $log_file
else
    touch $log_file
fi

for i in srva01 srva04; do
    for (( nb = 1; nb < 11; nb++ )) #Цикл по всем лезвиям
    do
	if [ $nb -ne 10 ]; then #Если лезвие не 10-ое, то добавляем ноль в DNS имя сервера
            sn=$i'b0'$nb
        else
            sn=$i'b'$nb
        fi
	ssh -q -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 $sn 'exit 0'
	if [[ $? -eq 0 ]]; then
	    state_virt=`sudo ssh $sn -o "StrictHostkeyChecking=no" ps aux | grep [l]ibvirt | wc -l`
            if [ $state_virt -ne 0 ]; then #0 - Libvirt не запущен или запущено несколько
		cv=`sudo virsh --connect qemu+ssh://root@$sn/system list | sed '1,2d' | awk '{print$2}' | wc -l`
		cv=$((cv-1))
		if [ $cv -ne 0 ]; then
		echo '' >> $log_file
		echo "==============================================" >> $log_file
		echo 'На сервере '$sn' развернуто '$cv' виртуальных машин' >> $log_file
		echo "==============================================" >> $log_file
		total_cpu=0
		total_mem=0
		for j in $(sudo virsh --connect qemu+ssh://root@$sn/system list | sed '1,2d' | awk '{print$2}'); do
		    count_cpu=`virsh --connect qemu+ssh://root@$sn/system dominfo $j | grep 'CPU(s)' | awk '{print $NF}'`
		    count_mem=`virsh --connect qemu+ssh://root@$sn/system dominfo $j | awk '/^Max/{print $3}'`
		    count_mem=`expr $count_mem / 1024 / 1024`
		    total_cpu=`expr $total_cpu + $count_cpu`
		    total_mem=`expr $total_mem + $count_mem`
		    echo '' >> $log_file
		    echo "==============================================" >> $log_file
		    echo "Имя виртуальной машины = "$j >> $log_file
		    echo "Количество выделенных ядер процессоров = "$count_cpu >> $log_file
		    echo "Количество выделенной оперативной памяти = "$count_mem" Gb" >> $log_file
		    echo "==============================================" >> $log_file
                done
		    echo '' >> $log_file
		    echo "==============================================" >> $log_file
		    echo 'Общее количество выделенных ресурсов на сервере '$sn >> $log_file
		    echo '' >> $log_file
		    echo "Общее количество выделенных процессоров = "$total_cpu >> $log_file
		    if [[ $total_cpu -gt 32 ]]; then
			echo "Количество выделенных, для виртуальных машин, ядер процессоров превышает количество физических ядер процессоров на сервере" >> $log_file
		    fi
		    echo "Общее количество выделенной оперативной памяти = "$total_mem" Gb" >> $log_file
		    if [[ $total_mem -gt 128 ]]; then
			echo "Количество выделенной, для виртуальных машин, оперативной памяти превышает объем физической оперативной памяти на сервере" >> $log_file
		    fi
		    echo "==============================================" >> $log_file
		else
		    echo "На сервере "$sn" отсутствуют виртуальные машины" >> $log_file
		fi
	    else echo "На сервере  "$sn" виртуализация не настроена" >> $log_file
	    fi
	else echo "Сервер "$sn" недоступен по SSH (вероятно сервер "$sn" выключен)" >> $log_file
	fi
    done
done

