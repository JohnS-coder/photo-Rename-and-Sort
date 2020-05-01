#!/bin/bash
read -p "Desktoptaki Fotoğraf Klasör adını girin: " klasor
echo Ekleme Başlıyor!
read -p "Klasör adını girin: " Klasor
if [ -e foto.xls ]
then
	read -p "foto.xls dosyası mevcut!..Üzerine yazılsın mı? (y/n): " onay
    if [ $onay == "y" ]
	then
		echo "Devam ediliyor...."
        sleep 2
        ls ./$klasor > foto.xls
	else
		break
	fi
	echo "Devam ediliyor...Sıkıntı yok.."
else
	ls ./$klasor > foto.xls
fi
echo Ekleme Bitti!
sleep 10
