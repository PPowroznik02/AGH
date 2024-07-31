namespace Zadanie07_PPowroznik;

public class InterfejsUzytkownika
{
    private OsobaManager manager = new OsobaManager();

    public void Uruchom()
    {
        while (true)
        {
            Console.WriteLine("Wybierz opcję:");
            Console.WriteLine("1. Dodaj osobę");
            Console.WriteLine("2. Usuń osobę");
            Console.WriteLine("3. Wyświetl wszystkie osoby");
            Console.WriteLine("4. Zapisz do pliku");
            Console.WriteLine("5. Odczytaj z pliku");
            Console.WriteLine("6. Szukaj po PESEL");
            Console.WriteLine("7. Szukaj po nazwisku");
            Console.WriteLine("8. Szukaj po mieście");
            Console.WriteLine("9. Zmień dane osoby");
            Console.WriteLine("10. Zapisz jedną osobę do pliku");
            Console.WriteLine("0. Wyjście");

            var opcja = Console.ReadLine();

            switch (opcja)
            {
                case "1":
                    DodajOsobe();
                    break;
                case "2":
                    UsunOsobe();
                    break;
                case "3":
                    WyswietlOsoby();
                    break;
                case "4":
                    ZapiszDoPliku();
                    break;
                case "5":
                    OdczytajZPliku();
                    break;
                case "6":
                    SzukajPoPeselu();
                    break;
                case "7":
                    SzukajPoNazwisku();
                    break;
                case "8":
                    SzukajPoMiescie();
                    break;
                case "9":
                    ZmienDaneOsoby();
                    break;
                case "10":
                    ZapiszJednaOsobeDoPliku();
                    break;
                case "0":
                    return;
                default:
                    Console.WriteLine("Nieznana opcja, spróbuj ponownie.");
                    break;
            }
        }
    }

    private void DodajOsobe()
    {
        var osoba = new Osoba();
        Console.WriteLine("Podaj id:");
        osoba.Id = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj imię:");
        osoba.Imie = Console.ReadLine();
        Console.WriteLine("Podaj nazwisko:");
        osoba.Nazwisko = Console.ReadLine();
        Console.WriteLine("Podaj wiek:");
        osoba.Wiek = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj wzrost (cm):");
        osoba.Wzrost = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj PESEL:");
        osoba.Pesel = Console.ReadLine();

        var adres = new Adres();
        Console.WriteLine("Podaj miasto:");
        adres.Miasto = Console.ReadLine();
        Console.WriteLine("Podaj kod pocztowy:");
        adres.KodPocztowy = Console.ReadLine();
        Console.WriteLine("Podaj nazwę ulicy:");
        adres.NazwaUlicy = Console.ReadLine();
        Console.WriteLine("Podaj nr domu:");
        adres.NrDomu = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj nr mieszkania:");
        adres.NrMieszkania = int.Parse(Console.ReadLine());

        osoba.AdresZamieszkania = adres;

        manager.DodajOsobe(osoba);
    }

    private void UsunOsobe()
    {
        Console.WriteLine("Podaj PESEL osoby do usunięcia:");
        var pesel = Console.ReadLine();
        manager.UsunOsobe(pesel);
    }

    private void WyswietlOsoby()
    {
        var osoby = manager.WyswietlOsoby();

        Console.WriteLine("Osoby: ");
        foreach (var osoba in osoby)
        {
            Console.WriteLine(osoba);
        }

        string wyjscie = "1";

        while (wyjscie != "0")
        {
            Console.WriteLine("0. Wyjscie");
            wyjscie = Console.ReadLine();
        }
    }

    private void ZapiszDoPliku()
    {
        Console.WriteLine("Podaj ścieżkę do pliku:");
        var sciezka = Console.ReadLine();
        manager.ZapiszDoPliku(sciezka);
    }

    private void OdczytajZPliku()
    {
        Console.WriteLine("Podaj ścieżkę do pliku:");
        var sciezka = Console.ReadLine();
        manager.OdczytajZPliku(sciezka);
    }

    private void SzukajPoPeselu()
    {
        Console.WriteLine("Podaj PESEL:");
        var pesel = Console.ReadLine();
        var osoby = manager.SzukajPoPeselu(pesel);

        Console.WriteLine("Osoby: ");
        foreach (var osoba in osoby)
        {
            Console.WriteLine(osoba);
        }

        Console.WriteLine("0. Wyjscie");
        string wyjscie = "1";

        while (wyjscie != "0")
        {
            wyjscie = Console.ReadLine();
        }
    }

    private void SzukajPoNazwisku()
    {
        Console.WriteLine("Podaj nazwisko:");
        var nazwisko = Console.ReadLine();
        var osoby = manager.SzukajPoNazwisku(nazwisko);

        Console.WriteLine("Osoby: ");
        foreach (var osoba in osoby)
        {
            Console.WriteLine(osoba);
        }

        Console.WriteLine("0. Wyjscie");
        string wyjscie = "1";

        while (wyjscie != "0")
        {
            wyjscie = Console.ReadLine();
        }
    }

    private void SzukajPoMiescie()
    {
        Console.WriteLine("Podaj miasto:");
        var miasto = Console.ReadLine();
        var osoby = manager.SzukajPoMiescie(miasto);

        Console.WriteLine("Osoby: ");
        foreach (var osoba in osoby)
        {
            Console.WriteLine(osoba);
        }

        string wyjscie = "1";

        while (wyjscie != "0")
        {
            Console.WriteLine("0. Wyjscie");
            wyjscie = Console.ReadLine();
        }
    }

    private void ZmienDaneOsoby()
    {
        Console.WriteLine("Podaj PESEL osoby do zmiany:");
        var pesel = Console.ReadLine();

        var noweDane = new Osoba();
        Console.WriteLine("Podaj nowe imię:");
        noweDane.Imie = Console.ReadLine();
        Console.WriteLine("Podaj nowe nazwisko:");
        noweDane.Nazwisko = Console.ReadLine();
        Console.WriteLine("Podaj nowy wiek:");
        noweDane.Wiek = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj nowy wzrost (cm):");
        noweDane.Wzrost = int.Parse(Console.ReadLine());

        var adres = new Adres();
        Console.WriteLine("Podaj nowe miasto:");
        adres.Miasto = Console.ReadLine();
        Console.WriteLine("Podaj nowy kod pocztowy:");
        adres.KodPocztowy = Console.ReadLine();
        Console.WriteLine("Podaj nową nazwę ulicy:");
        adres.NazwaUlicy = Console.ReadLine();
        Console.WriteLine("Podaj nowy nr domu:");
        adres.NrDomu = int.Parse(Console.ReadLine());
        Console.WriteLine("Podaj nowy nr mieszkania:");
        adres.NrMieszkania = int.Parse(Console.ReadLine());

        noweDane.AdresZamieszkania = adres;

        manager.ZmienDaneOsoby(pesel, noweDane);
    }
    
    private void ZapiszJednaOsobeDoPliku()
    {
        Console.WriteLine("Podaj PESEL osoby do zapisu:");
        var pesel = Console.ReadLine();
        Console.WriteLine("Podaj ścieżkę pliku do zapisu:");
        var sciezka = Console.ReadLine();
        manager.ZapiszJednaOsobeDoPliku(pesel, sciezka);
    }
    
}