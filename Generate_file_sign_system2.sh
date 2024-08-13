#!/bin/bash


echo "Write the detail inside the file:"

read -r custom_data


echo "Generating file with custom data..."

echo "$custom_data" > dailyfile.txt

echo "File generated at $(date)."


echo "Encrypting the file..."

openssl pkeyutl -encrypt -inkey denishkey.pub -pubin -in dailyfile.txt -out dailyfile.txt.enc

if [ $? -eq 0 ]; then

    echo "File encrypted."

else

    echo "Encryption failed."

    exit 1

fi



echo "Creating digital signature..."

openssl dgst -sha256 -sign makiikey.pem -out dailyfile.sig dailyfile.txt

if [ $? -eq 0 ]; then

    echo "Digital signature created."

else

    echo "Failed."

    exit 1

fi



echo "Transferring files to makii..."

scp dailyfile.txt.enc dailyfile.sig denish@192.168.56.101:~/Desktop/system1/

if [ $? -eq 0 ]; then

    echo "Transfer complete."

else

    echo "Transfer failed."

    exit 1

fi

