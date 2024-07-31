#!/bin/bash
#Piotr Powroznik


#0 START
start_time=$( echo $(date +"%s.%6N") | tr -d "." )	#zapisanie czasu poczatkowego w mikrosekundach  do zmiennej
#0 STOP


#sprawdzenie poprawnosci uruchomienia skryptu
if [[ $# == 0 ]]
then 
	echo "brak argumentow, poprawne uruchomienie ./poprawka2.sh <KAT_BAZOWY> <nazwa_pliku_danych1> <nazwa_pliku_danych2> ... <nazwa_pliku_danychN>" 1>&2
	exit 1
elif [[ $# == 1 ]] 
then
	echo "podano tylko jeden argument" 1>&2
	exit 2
fi


#sprawdzenie poprawnosci plikow danych
for file in "${@:2}"
do
	#spradzenie czy plik istnieje
	if [[ ! -f "$file" ]]
	then
		echo "brak dostepu do pliku danych, lub plik nie istnieje: "$file"" 1>&2
		exit 3
	fi
done


#sprawdzenie czy katalog bazowy istnieje i utworzenie go gdyby nie istanial
if [[ ! -d "$1" ]]
then
	mkdir -m 750 "$1"
fi


#sprawdzenie czy katalog zostal utworzony
if [[ ! -d "$1" ]]
then 
	echo "brak mozliwosci utworzenia katalogu bazowego" 1>&2
	exit 4
fi



for file in "${@:2}"
do 

	while read line
	do
		#1 START
		year=$( echo "$line" | cut -d "," -f 3 | tr -d "\"" )	#wyciecie informacji o roku
		month=$( echo "$line" | cut -d "," -f 4 | tr -d "\"" )	#wyciecie informacji o miesiacu
		
		#utworzenie katalogu gdyby nie istnial
		if [[ ! -d "$1/$year/$month" ]]
		then
			mkdir -m 750 -p "$1/$year/$month"
			chmod 750 "$1/$year"
		fi

		smdb=$( echo "$line" | cut -d "," -f 7| tr -d "\"" )	#wyciecie informacji o statusie pomiaru
		day=$( echo "$line" | cut -d "," -f 5 | tr -d "\"" )	#wyciecie informacji o dniu
		#1 STOP


		#2,3 START
		if [[ $smdb -ne 8 ]]
		then
			#utworzenie pliku .csv gdyby nie istnial
			if [[ ! -f "$1/$year/$month/$day.csv" ]]
			then
				touch "$1/$year/$month/$day.csv"
				chmod 640 "$1/$year/$month/$day.csv"
			fi

			echo "$line" >> "$1/$year/$month/$day.csv"	#zapisanie lini do pliku
		else
			#utworzenie pliku .errors gdyby nie istnial
			if [[ ! -f "$1/$year.$month.errors" ]]
			then
				touch "$1/$year.$month.errors" 
				chmod 640 "$1/$year.$month.errors"
			fi
			
			echo "$line" >> "$1/$year.$month.errors"	#zapisanie lini do pliku
		fi
		#2,3 STOP


	done < "$file"

done



#4 START 
#zapisanie sciezek do wszystkich plikow .csv, znajdujacych sie w katalogu bazowym, do pliku paths.txt
find "$1" -type f -name "*.csv" > "$1/paths.txt"


while read path 
do
	p=$( echo $path | sed 's/ /\\ /g' )	#czytanie pliku linia po lini usuwalo znaki \, wiec nalezalo je przywrocic
	echo -n "$p, " >> "$1/tmp.txt"		#zapisanie sciezek w pliku tmp.txt

	#obliczenie sumy opadow w pliku .csv, i wypisanie jej po przecinku w pliku tmp.txt
	echo "$p" | xargs cat | cut -d "," -f 6 | tr -d "\"" | awk '{sum+=$1} END {print sum}'  >> "$1/tmp.txt" 
done < "$1/paths.txt"


min_path=$(cat "$1/tmp.txt" | sort -n -t ',' -k 2 | head -n 1 | cut -d "," -f 1)	#bezwzgledna sciezka do pliku z min opadami
max_path=$(cat "$1/tmp.txt" | sort -n -t ',' -k 2 | tail -n 1 | cut -d "," -f 1)	#bezwzgledna sciezka do pliku z max opadami

#wyciecie tylko koncowki sciezek do plikow z max i min opadami 
min_path=$( echo "$min_path" | rev | cut -d "/" -f 1,2,3 | rev )	
max_path=$( echo "$max_path" | rev | cut -d "/" -f 1,2,3 | rev )


#utworzenie katalogu LINKS gdyby nie istnial
if [[ ! -d "$1/LINKS" ]]
then 
	mkdir -m 750 "$1/LINKS"
fi

#utworzenie linkow symbolicznych, lub zastapienie istniejacych linkow na nowe
ln -sf "../$min_path" "$1/LINKS/MIN_OPAD"
ln -sf "../$max_path" "$1/LINKS/MAX_OPAD"
#4 STOP

#usuniecie tymczasowych plikow
rm "$1/tmp.txt"		
rm "$1/paths.txt"	


#0 START
end_time=$(echo $(date +"%s.%6N") | tr -d ".")	#zapisanie czasu koncowego w mikrosekundach do zmiennej

execution_time=$(( end_time - start_time ))	#obiczenie czasu dzialania skryptu w mikrosekundach
execution_time=$( printf "%.3f" $( echo "$execution_time / 1000" | bc -l ) )	#zamiana czasu na milisekundy

#wypisanie informacji o dzialaniu skryptu do pliku out.log
echo "$$, $PPID, $execution_time, $(echo $( echo $( ( for arg in "$@"; do echo "$arg, "; done ) ) | rev | cut -c 2- | rev  ))" >> "$1/out.log" 
chmod 640 "$1/out.log"
#0 STOP
