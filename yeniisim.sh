#!/bin/bash
while True
do
	read -p "Klasör adını girin: " Klasor
	if [ -e "$Klasor/newfoto" ]
	then
		echo "newfoto klasörü mevcut.."
		echo "Devam ediliyor...Sıkıntı yok.."
	else
		mkdir "$Klasor/newfoto"
	fi
	ff=0
	strno=$( cat foto.csv | wc -l ) 
	for (( i=1; i<="$strno"; i++ ))
	do
		ad=$( sed -n "$i"p foto.csv | cut -f1 -d ";" )
		ad2=$( sed -n "$i"p foto.csv | cut -f2 -d ";" )
		if [ -e "$Klasor/$ad" ]
		then
			if [ -e "$Klasor/newfoto/$ad2" ]
			then
				jpg=$( echo "$ad2" | cut -d "." -f2 )
				asil=$( echo "$ad2" | cut -d "." -f1 )
				say=$( ls "$Klasor/newfoto" | grep -w "$asil" | wc -l )
				kopy="$asil Copy($say) .$jpg"
				cp -i -v  "$Klasor/$ad" "$Klasor/newfoto/$kopy"
			else
				cp -i -v  "$Klasor/$ad" "$Klasor/newfoto/$ad2"
			fi
			(( ff++ ))
		else
			echo "$ad mevcut değil.."
			sleep 5
		fi
	done
	echo
	echo
	echo " $ff dosya değiştirildi.."
	echo
	echo
	echo "Bölünmeden önce $Klasor/newfoto klasörünü kontrol edin."
	read -p "Devam edilsin mi? (y/n): " onay
	if [ $onay == "y" ]
	then
		echo "Devam ediliyor...."
	else
		break
	fi

	echo ".................................................................."
	echo "..Yeni isimli dosyalar topluca $Klasor/newfoto klasöründedir......"
	echo "...................LÜTFEN BEKLEYİN................................"
	echo "..................BÖLÜNME BAŞLIYOR!..............................."
	sleep 2
	ls $Klasor/newfoto > newfilelist.csv 
	uniqsayi=$( ls "$Klasor/newfoto" | cut -d "_" -f1  | sort | uniq | wc -l ) 
	for (( i=1; i<="$uniqsayi"; i++ ))
	do
		uniqdir=$( ls "$Klasor/newfoto" | cut -d "_" -f1  | sort | uniq | sed -n "$i"p )
		if [ -e "$Klasor/newfoto/$uniqdir" ]
		then
			echo "$uniqdir klasörü mevcut.."
		else
			mkdir "$Klasor/newfoto/$uniqdir"
		fi
	done
	ss=0
	strno=$( ls "$Klasor/newfoto" | wc -l )
	for (( i=1; i<="$uniqsayi"; i++ ))
	do
		uniqdir=$( cat newfilelist.csv | cut -d "_" -f1  | sort | uniq |sed -n "$i"p )
		for (( z=1; z<="$strno"; z++ ))
		do
			file=$( cat newfilelist.csv | sed -n "$z"p )
			filex=$( echo "$file" | cut -d "_" -f1 )
			if [ -d "$Klasor/newfoto/$file" ] 
			then
				echo "Not file $file"
			else
				if [ "$filex" == "$uniqdir" ]
				then
					if [ -e "$Klasor/newfoto/$uniqdir/$file" ]
					then
						jpg=$( echo $file | cut -d "." -f2 )
						asil=$( echo $file | cut -d "." -f1 )
						say=$( ls "$Klasor/newfoto/$uniqdir" | grep -w "$asil" | wc -l )
						kopy="$asil Copy($say) .$jpg"
						mv -v -i "$Klasor/newfoto/$file" "$Klasor/newfoto/$uniqdir/$kopy"
					else
						mv -v -i "$Klasor/newfoto/$file" "$Klasor/newfoto/$uniqdir/"
					fi
					(( ss++ ))
				else
					echo $file eşit değil  $uniqdir..
				fi
			fi
		done
	done
	rm -r newfilelist.csv
	echo
	echo
	echo "$ss dosya dağıtımı tamamlandı.."
	echo ".................................................................."
	echo "..Yeni isimli dosyalarınız $Klasor/newfoto içinde klasörlerdedir.."
	echo ".................................................................."
	echo
	read -p "Çıkış yapılsın mı?? (y/n): " onay
	if [ $onay == "y" ]
	then
		break
	else
		echo "Bekleniyor....30 sn içinde kapanacak!"
		sleep 30
		break
	fi
done


