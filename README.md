# WeatherStation
Projekt stacji meteoroloicznej - pobieranie i gromadzenie
danych pogodowych ze strony wttr.in dla wybranego miasta.

Zawartość:
-rx_poc.log - tabelka na dane z kolumani rok/miesiac/dzien/temp
w którym bedą zapisywane i przechowywane dane temperaturowe
-rx_poc.sh - skrypt pobierający dane, który będziemy uruchamiać ręcznie,
żeby pobrać dane lub zautomatyzować uruchamianie co określony czas. 
-fc_accuracy.sh - skrypt weryfkujący (w danej skali) czy prognozy z 
dznia wcześniej okazały się skuteczne, i gromadząc takie dane do
pliku historical_fc_accuracy.tsv
-historical_fc_accuracy.tsv - dane odnośnie skuteczności prognoz pogody

Korzystanie:
1.Uruchomić skrypt 'rx_poc.sh' pobierze aktualną temperature oraz prognozę na następny dzień dla dowolnego miasta, które jest zdefiniowane w skrypcie(można edytować zmienna $city) wyświetli te informacje w konsoli i zapisze dane w plku logów 'rx_poc.log'
2. Codzienne uruchamianie zgromadzi nam dane temperaturowe mając minimum dwa wpisy
uruchamiamy skkrypt 'fc_accuract.sh' ten na bazie danych z pliku logów określi stopień
dokładności prognoz porównując wczorajszą prognozę do dzisiejszej temperatury wg. skali:
accuracy range | accuracy label
+/- 1 st.        excellent
+/- 2 st.        good
+/- 3 st.        fair
+/- 4 st.        bad
Dane bedą gromadzone w pliku historical_fc_accuracy.tsv

