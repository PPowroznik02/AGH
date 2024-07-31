using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plikowe
{
    internal class TestyBazy
    {
        public void dodajOsoby(ZapisBazy db)
        {
            Adres adres1 = new Adres()
            {
                ID = 1,
                Miasto = "Tarnow",
                Ulica = "Walowa",
                NrDomu = 23,
                NrMieszkania = 23,
                Kod_pocztowy = "33-100"
            };

            Adres adres2 = new Adres()
            {
                ID = 2,
                Miasto = "Krakow",
                Ulica = "Emaus",
                NrDomu = 1,
                NrMieszkania = 1,
                Kod_pocztowy = "33-80"
            };

            db.DodajAdres(adres1);
            db.DodajAdres(adres2);

            string stan = "1";

            while (stan != "0")
            {
                Console.WriteLine("Jesli chcesz dodac osobe wybierz 1");
                Console.WriteLine("Jesli chcesz dodac adres wybierz 2");
                Console.WriteLine("Jesli chcesz wypisac dostepne osoby wybierz 3");
                Console.WriteLine("Jesli chcesz wypisac dostepne adresy wybierz 4");
                Console.WriteLine("Jesli chcesz wyjsc wybierz 0");

                stan = Console.ReadLine();

                if (stan == "1")
                {
                    int id = znajdzMaxIdOsoba(db) + 1;
                    Console.WriteLine("Podaj imie");
                    string imie = Console.ReadLine();
                    Console.WriteLine("Podaj nazwisko");
                    string nazwisko = Console.ReadLine();
                    Console.WriteLine("Podaj wiek");
                    int wiek = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj wzrost");
                    int wzrost = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj id adresu");
                    int idAdr = int.Parse(Console.ReadLine());

                    Adres adres = this.znajdzAdres(db, idAdr);

                    Osoba os = new Osoba()
                    {
                        ID = id,
                        Imie = imie,
                        Nazwisko = nazwisko,
                        Wiek = wiek,
                        Wzrost = wzrost,
                        Adres = adres
                    };


                    db.DodajOsobe(os);
                }
                else if (stan == "2")
                {
                    int id = znajdzMaxIdAdres(db) + 1;
                    Console.WriteLine("Podaj miasto");
                    string miasto = Console.ReadLine();
                    Console.WriteLine("Podaj ulice");
                    string ulica = Console.ReadLine();
                    Console.WriteLine("Podaj nr domu");
                    int nrDomu = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj nr mieszkania");
                    int nrMieszkania = int.Parse(Console.ReadLine());
                    Console.WriteLine("Podaj kod pocztowy");
                    string kodPocztowy = Console.ReadLine();

                    Adres adres = new Adres()
                    {
                        ID = id,
                        Miasto = miasto,
                        Ulica = ulica,
                        NrDomu = nrDomu,
                        NrMieszkania = nrMieszkania,
                        Kod_pocztowy = kodPocztowy
                    };


                    db.DodajAdres(adres);
                }
                else if (stan == "3")
                {
                    string stanWew = "1";
                    Console.WriteLine("Osoby:");
                    this.wypiszDostepneOsoby(db);
                    
                    Console.WriteLine("Jesli chcesz wyjsc wybierz 0");
                    stanWew = Console.ReadLine();

                    if (stanWew != "0")
                    {
                        Console.WriteLine("Osoby:");
                        this.wypiszDostepneOsoby(db);
                        Console.WriteLine("Jesli chcesz wyjsc wybierz 0");
                        stanWew = Console.ReadLine();
                    }
                }
                else if (stan == "4")
                {
                    
                    string stanWew = "1";
                    Console.WriteLine("Osoby:");
                    this.wypiszDostepneAdresy(db);
                    
                    Console.WriteLine("Jesli chcesz wyjsc wybierz 0");
                    stanWew = Console.ReadLine();

                    if (stanWew != "0")
                    {
                        Console.WriteLine("Osoby:");
                        this.wypiszDostepneAdresy(db);
                        Console.WriteLine("Jesli chcesz wyjsc wybierz 0");
                        stanWew = Console.ReadLine();
                    }
                }
                else if (stan == "0")
                {
                    break;
                }
                else
                {
                    Console.WriteLine("Wybierz poprawna opcje");
                }
            }
        }

        public void pokazBaze(ZapisBazy db)
        {
            Console.WriteLine();
            Console.WriteLine("Podgląd bazy danych:");
            Console.WriteLine("Osoby:");
            foreach (Osoba osoba in db.OsobyKolekcja)
            {
                Console.WriteLine(osoba);
            }

            Console.WriteLine("Adresy:");
            foreach (Adres adres in db.AdresyKolekcja)
            {
                Console.WriteLine(adres);
            }
        }

        public Adres znajdzAdres(ZapisBazy db, int id)
        {
            foreach (Adres adres in db.AdresyKolekcja)
            {
                if (adres.ID == id)
                {
                    return (adres);
                }
            }

            return (null);
        }

        public int znajdzMaxIdAdres(ZapisBazy db)
        {
            int id = 0;
            foreach (Adres adres in db.AdresyKolekcja)
            {
                if (adres.ID > id)
                {
                    id = adres.ID;
                }
            }

            return (id);
        }

        public int znajdzMaxIdOsoba(ZapisBazy db)
        {
            int id = 0;
            foreach (Osoba osoba in db.OsobyKolekcja)
            {
                if (osoba.ID > id)
                {
                    id = osoba.ID;
                }
            }

            return (id);
        }

        public void wypiszDostepneAdresy(ZapisBazy db)
        {
            foreach (Adres adres in db.AdresyKolekcja)
            {
                Console.WriteLine(adres);
            }
        }

        public void wypiszDostepneOsoby(ZapisBazy db)
        {
            foreach (Osoba osoba in db.OsobyKolekcja)
            {
                Console.WriteLine(osoba);
            }
        }
    }
}