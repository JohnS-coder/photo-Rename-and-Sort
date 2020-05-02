#!/bin/bash
while True 
do
	echo "--------Ekleme Başlıyor!-------------"
	read -p "Klasör adını girin: " klasor
	if [ -e foto.csv ]
	then
		read -p "foto.xls dosyası mevcut!..Üzerine yazılsın mı? (y/n): " onay
		if [ $onay == "y" ]
		then
			echo "Devam ediliyor...."
			sleep 2
			ls $klasor > foto.csv
		else
			break
		fi
		echo "Devam ediliyor...Sıkıntı yok.."
	else
		ls $klasor > foto.csv
	fi
	echo Ekleme Bitti!
	break
done