using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace czwartek_d_Linq
{
    internal class Osoba_kol
    {
        private List<Osoba> listaOsob;

        private void dodajListeOsob()
        {
            listaOsob = new List<Osoba>()
            {
                new Osoba()
                {
                    Id = 1, Imie = "Jan", Nazwisko = "Firlit", Wiek = 12, NrTelefonu = "948382832",
                    Pesel = "02050623842", Wykształcenie = "srednie"
                },
                new Osoba()
                {
                    Id = 2, Imie = "Marcin", Nazwisko = "Malon", Wiek = 32, NrTelefonu = "990560650",
                    Pesel = "02050623842", Wykształcenie = "podstawowe"
                },
                new Osoba()
                {
                    Id = 3, Imie = "Marina", Nazwisko = "Byk", Wiek = 22, NrTelefonu = "112114115",
                    Pesel = "02345623842", Wykształcenie = "wyzsze"
                },
                new Osoba()
                {
                    Id = 4, Imie = "Iza", Nazwisko = "Malon", Wiek = 4, NrTelefonu = "989456321", Pesel = "02057633842",
                    Wykształcenie = "brak"
                },
                new Osoba()
                {
                    Id = 5, Imie = "Iza", Nazwisko = "Firlit", Wiek = 33, NrTelefonu = "865784786",
                    Pesel = "13450623842", Wykształcenie = "wyzsze"
                },
                new Osoba()
                {
                    Id = 6, Imie = "Krystyna", Nazwisko = "Byk", Wiek = 19, NrTelefonu = "859352832",
                    Pesel = "00028349582", Wykształcenie = "podstawowe"
                },
            };
        }

        private void dodajOsobe(string imie, string nazwisko, int wiek, string nrTelefonu, string pesel,
            string wyksztalcenie)
        {
            int maxId = 0;
            var ids = from osoba in listaOsob
                orderby osoba.Id
                select osoba.Id;

            foreach (var element in ids)
            {
                if (maxId < element)
                {
                    maxId = element;
                }
            }

            listaOsob.Add(new Osoba()
            {
                Id = maxId + 1, Imie = imie, Nazwisko = nazwisko, Wiek = wiek, NrTelefonu = nrTelefonu, Pesel = pesel,
                Wykształcenie = wyksztalcenie
            });
        }

        private void dodajOsobePrzezUzytkownika()
        {
            string imie, nazwisko, nrTelefonu, pesel, wyksztalcenie;
            int wiek;

            Console.WriteLine("Podaj imie: ");
            imie = Console.ReadLine();
            Console.WriteLine("Podaj nazwisko: ");
            nazwisko = Console.ReadLine();
            Console.WriteLine("Podaj wiek: ");
            wiek = int.Parse(Console.ReadLine());
            Console.WriteLine("Podaj nr telefonu: ");
            nrTelefonu = Console.ReadLine();
            Console.WriteLine("Podaj pesel: ");
            pesel = Console.ReadLine();
            Console.WriteLine("Podaj wyksztalcenie: ");
            wyksztalcenie = Console.ReadLine();

            dodajOsobe(imie, nazwisko, wiek, nrTelefonu, pesel, wyksztalcenie);
        }

        public void uruchom()
        {
            dodajListeOsob();


            var ListaOsobDodanych = from osoba in listaOsob
                select osoba;
            Console.WriteLine("Zawartość kolekcji:");
            foreach (var element in ListaOsobDodanych)
                Console.WriteLine(element);
            Console.WriteLine();

            var ListaOsobDoroslych = from osoba in listaOsob
                where osoba.Wiek >= 18
                select osoba;

            foreach (var element in ListaOsobDoroslych)
                Console.WriteLine(element);
            Console.WriteLine();

            Osoba pierwsza = ListaOsobDodanych.First<Osoba>();
            Console.WriteLine("Pierwsza osoba w kolekcji to: " + pierwsza.ToString());
            pierwsza.Imie = "Adam";

            foreach (var element in ListaOsobDodanych)
                Console.WriteLine(element);
            Console.WriteLine();

            var ListaOsobDoroslych2 = from osoba in listaOsob
                where osoba.Wiek >= 18
                orderby osoba.Wiek
                select osoba;

            foreach (var element in ListaOsobDoroslych2)
                Console.WriteLine(element);
            Console.WriteLine();

            Console.WriteLine("Najstarsza osoba w kolekcji ma: " + ListaOsobDodanych.Max(osoba => osoba.Wiek));
            Console.WriteLine();
            Console.WriteLine("Osoby o tym samym nazwisku:");
            var Nazwiska = from osoba in listaOsob
                group osoba by osoba.Nazwisko
                into grupa
                select grupa;
            foreach (var grupa in Nazwiska)
            {
                Console.WriteLine("Osoby o nazwisku: " + grupa.Key);
                foreach (var osoba in grupa)
                {
                    Console.WriteLine(osoba.ToString());
                }

                Console.WriteLine();
            }

            Console.WriteLine();

            var ListaImion = from osoba in listaOsob
                select new { osoba.Id, osoba.Imie };

            foreach (var osoba in ListaImion)
            {
                Console.WriteLine(osoba.ToString());
            }

            Console.WriteLine();

            var ListaNazwisk = from osoba in listaOsob
                select new { osoba.Id, osoba.Nazwisko };

            var ListaWiek = from osoba in listaOsob
                select new { osoba.Id, osoba.Wiek };

            foreach (var osoba in ListaNazwisk)
            {
                Console.WriteLine(osoba.ToString());
            }

            Console.WriteLine();

            foreach (var osoba in ListaWiek)
            {
                Console.WriteLine(osoba.ToString());
            }

            Console.WriteLine();

            var ListaWiekNazwiska = from nazwiska in ListaNazwisk
                join
                    wiek in ListaWiek
                    on nazwiska.Id equals wiek.Id
                select new { nazwiska.Id, nazwiska.Nazwisko, wiek.Wiek };

            foreach (var osoba in ListaWiekNazwiska)
            {
                Console.WriteLine(osoba.ToString());
            }

            Console.WriteLine();


            //Zadania
            dodajOsobe(imie: "Jan", nazwisko: "Maj", wiek: 45, nrTelefonu: "567454456", pesel: "22343245623",
                wyksztalcenie: "srednie");

            dodajOsobe(imie: "Janina", nazwisko: "Żak", wiek: 22, nrTelefonu: "099954456", pesel: "34598778975",
                wyksztalcenie: "srednie");

            //dodajOsobePrzezUzytkownika();

            Console.WriteLine("Query 1");
            var powtorzoneImiona = from osoba in listaOsob
                group osoba by osoba.Imie
                into grouped
                where grouped.Count() > 1
                select new { Imie = grouped.Key, Count = grouped.Count() };

            foreach (var el in powtorzoneImiona)
            {
                Console.WriteLine(el);
            }


            Console.WriteLine("Query 2");
            Console.WriteLine("Podaj wiek najmlodszej osoby: ");
            int wiekMin = int.Parse(Console.ReadLine());

            var osobyStarsze = from osoba in listaOsob
                where osoba.Wiek > wiekMin
                select osoba;

            foreach (var el in osobyStarsze)
            {
                Console.WriteLine(el);
            }

            Console.WriteLine("Query 3");

            var osobyPosortowane = from osoba in listaOsob
                orderby osoba.Id descending
                select osoba;

            foreach (var el in osobyPosortowane)
            {
                Console.WriteLine(el);
            }

            Console.WriteLine("Query 4");

            var osobyGrupownieWyksztalcenie = from osoba in listaOsob
                group osoba by osoba.Wykształcenie
                into zgrupowane
                select new { Wyksztalcenie = zgrupowane.Key, Count = zgrupowane.Count() };

            foreach (var el in osobyGrupownieWyksztalcenie)
            {
                Console.WriteLine(el);
            }

            Console.WriteLine("Query 5");

            var osobaMaxWiek = listaOsob.OrderByDescending(o => o.Wiek).First();

            Console.WriteLine(osobaMaxWiek);
            
            Console.WriteLine("Query 6");

            var osobaMinWiek = listaOsob.OrderBy(o => o.Wiek).OrderBy(o => o.Id).First();

            Console.WriteLine(osobaMinWiek);
        }
    }
}