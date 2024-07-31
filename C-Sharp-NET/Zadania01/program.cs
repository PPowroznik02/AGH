namespace ConsoleApp70;
using System.Text;



internal class program 
{
    static void Main(string[] args)
    {
        
        //Zadanie_konstruktor 1 
        
        Osoba osoba1 = new Osoba();
        Console.WriteLine("Osoba1");
        Console.WriteLine(osoba1);

        Osoba osoba2 = new Osoba("Szczepan");
        Console.WriteLine("Osoba2");
        Console.WriteLine(osoba2.Imie);
        
        Osoba osoba3 = new Osoba("Jan", "Maj");
        Console.WriteLine("Osoba3");
        Console.WriteLine(osoba3.Imie + " " + osoba3.Nazwisko);
        
        Osoba osoba4 = new Osoba("Jan", "Maj", "Konwaliowa", "10-140", "Podole", 10);
        Console.WriteLine("Osoba4");
        Console.WriteLine(osoba4.Imie + " " + osoba4.Nazwisko + " " + osoba4.Ulica + " " + osoba4.Kod + " " + osoba4.Miasto + " " + osoba4.Nr_ulicy);
        
        
        //Zadanie_konstruktor 2
        /*
        Singleton singleton1 = Singleton.Instancja();
        Singleton singleton2 = Singleton.Instancja();

        if (singleton1 == singleton2)
        {
            Console.WriteLine("Obie instancje sa indentyczne");
        }
        else
        {
            Console.WriteLine("Instancje nie sa indentyczne");
        }
        */

        
        //Zadanie_krotki 1 
        /*
        Krotki nowe_krotki = new Krotki(2);
        nowe_krotki.wypisz();
        */
        
        //Zadanie_krotki 2
        /*
        Test_metod nowy_test = new Test_metod(2, 5, 7, 5);
        (long, long) wynik1 = nowy_test.potegowanie_mnozenie(9, 4);
        (long, long) wynik2 = nowy_test.dzielenie(9, 4);
        Console.WriteLine("Mnozenie, Potega" + wynik1);
        Console.WriteLine("Dzielenie, Reszta" + wynik2);
        */
        
        //Zadanie polimorfizm
        /*
        Kadra nowa_kadra = new Kadra();
        nowa_kadra.wczytaj();
        bool res = nowa_kadra.test_pesel();
        Console.WriteLine("Rezultat: " + res);
        nowa_kadra.wypisz();
        */
        
        //Zadanie typy wewnetrzne
        /*
        Osoba2 osoba2 = new Osoba2 { Imie = "Jan", Nazwisko = "Kowalski" };
        osoba2.DodajAdres("Długa", "10-100", "Kraków", 7, 10, "zameldowania");
        osoba2.DodajAdres("Krótka", "33-100", "Tarnów", 3, 0, "zamieszkania");
        osoba2.DodajAdres("Szeroka", "20-120", "Ciechocinek", 6, 0, "pracy");
        
        osoba2.wyswietl_adresy();
        */
        

    }
}