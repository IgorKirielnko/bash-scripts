#!/bin/bash

# Проверяем, что переданы оба файла
if [ $# -ne 2 ]; then
    echo "Использование: $0 файл1 файл2"
    exit 1
fi

file1=$1
file2=$2


# Создаем временный файл для хранения строк из второго файла
#tmpfile=$(mktemp)
#trap 'rm -f "$tmpfile"' EXIT # Удалим временный файл при завершении

# Копируем содержимое второго файла в временный файл
tmpfile1='/tmp/selectel'
tmpfile2='/tmp/ruhw'
cp "$file1" "$tmpfile1"
cp "$file2" "$tmpfile2"

# Перебираем строки первого файла с нумерацией
CountLine=$(wc -l ${tmpfile1}|cut -c -2)
while [[ $CountLine > 1 ]]
do
Line1=$(sed -n 1p ${tmpfile1}|cut -d ' ' -f 1)
Line2=$(sed -n 1p ${tmpfile2}|cut -d ' ' -f 1)
diff <(echo "$Line1") <(echo "$Line2")

sed 1d -i ${tmpfile1}
sed 1d -i ${tmpfile2}
CountLine=$(wc -l ${tmpfile1}|cut -c -2)
done
#while IFS= read -r line || [[ -n "$line" ]]; do
#    # Проверяем, есть ли такая строка во временном файле
#    if ! grep -qFx "$line" "$tmpfile"; then
#        # Если нет - выводим номер строки и саму строку
#        echo "Строка $LINENO: $line"
#    fi
#done < "$file1"
