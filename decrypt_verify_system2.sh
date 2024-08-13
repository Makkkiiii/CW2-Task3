#!/bin/bash


echo "Decrypting data from denish..."

openssl pkeyutl -decrypt -inkey makiikey.pem -in dailyfile.txt.enc -out dailyfile.txt

if [ $? -eq 0 ]; then

    echo "Data decrypted."

else

    echo "Decryption failed."

    exit 1

fi

echo "Verifying signature..."

openssl dgst -sha256 -verify denishkey.pub -signature dailyfile.sig dailyfile.txt

if [ $? -eq 0 ]; then

    echo "Signature verified successfully."

else

    echo "Signature verification failed."

fi

