#!/bin/bash
echo 'Insert INN for find ID'
read INN
echo 'Insert KPP for find ID'
read KPP
export ID=$(su - db2inst1 -c "db2 connect to UZDO; db2 SELECT REMOTE_KEY from UZDOUSER.CONTRACTORS WHERE INN = \'$INN\' AND KPP = \'$KPP\'"|grep -E '^[0-9]')
echo -e "\n\n\n found id:$ID \n\n\n"
echo 'Insert BIK for TRIGGER & UPDATE'
read BIK
echo 'Insert CURRENT_ACCOUNT for TRIGGER & UPDATE'
read CA
echo 'Insert BANK_NAME for TRIGGER & UPDATE'
read BANK
su - db2inst1 -c "db2 connect to UZDO; db2 CREATE TRIGGER UZDOUSER.BANK_TRIGGER_$ID AFTER INSERT ON UZDOUSER.CONTRACTORS FOR EACH ROW UPDATE UZDOUSER.CONTRACTORS SET BIK = \'$BIK\', CURRENT_ACCOUNT = \'$CA\', BANK_NAME = \'$BANK\' WHERE REMOTE_KEY = \'$ID\'; db2 UPDATE UZDOUSER.CONTRACTORS SET BIK = \'$BIK\', CURRENT_ACCOUNT = \'$CA\', BANK_NAME = \'$BANK\' WHERE REMOTE_KEY = \'$ID\'; db2 SELECT remote_key, short_name, inn, kpp, current_account, bik, bank_name FROM UZDOUSER.CONTRACTORS WHERE REMOTE_KEY = \'$ID\'; db2 drop trigger UZDOUSER.BANK_TRIGGER_$ID"
