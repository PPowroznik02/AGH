namespace Zadanie07_PPowroznik;

public class OsobaManager
{
    private List<Osoba> osoby = new List<Osoba>();

    public void DodajOsobe(Osoba osoba)
    {
        osoby.Add(osoba);
    }

    public void UsunOsobe(string pesel)
    {
        osoby.RemoveAll(o => o.Pesel == pesel);
    }

    public List<Osoba> WyswietlOsoby()
    {
        return new List<Osoba>(osoby);
    }

    public void ZapiszDoPliku(string sciezka)
    {
        using (StreamWriter sw = new StreamWriter(sciezka))
        {
            foreach (var osoba in osoby)
            {
                sw.WriteLine(
                    $"{osoba.Id}|{osoba.Imie}|{osoba.Nazwisko}|{osoba.Wiek}|{osoba.Wzrost}|{osoba.Pesel}|{osoba.AdresZamieszkania.Miasto}|{osoba.AdresZamieszkania.KodPocztowy}|{osoba.AdresZamieszkania.NazwaUlicy}|{osoba.AdresZamieszkania.NrDomu}|{osoba.AdresZamieszkania.NrMieszkania}");
            }
        }
    }

    public void OdczytajZPliku(string sciezka)
    {
        osoby.Clear();
        using (StreamReader sr = new StreamReader(sciezka))
        {
            string linia;
            while ((linia = sr.ReadLine()) != null)
            {
                var dane = linia.Split('|');
                var adres = new Adres
                {
                    Miasto = dane[6],
                    KodPocztowy = dane[7],
                    NazwaUlicy = dane[8],
                    NrDomu = int.Parse(dane[9]),
                    NrMieszkania = int.Parse(dane[10])
                };
                var osoba = new Osoba
                {
                    Id = int.Parse(dane[0]),
                    Imie = dane[1],
                    Nazwisko = dane[2],
                    Wiek = int.Parse(dane[3]),
                    Wzrost = int.Parse(dane[4]),
                    Pesel = dane[5],
                    AdresZamieszkania = adres
                };
                osoby.Add(osoba);
            }
        }
    }

    public List<Osoba> SzukajPoPeselu(string pesel)
    {
        return osoby.Where(o => o.Pesel == pesel).ToList();
    }

    public List<Osoba> SzukajPoNazwisku(string nazwisko)
    {
        return osoby.Where(o => o.Nazwisko == nazwisko).ToList();
    }

    public List<Osoba> SzukajPoMiescie(string miasto)
    {
        return osoby.Where(o => o.AdresZamieszkania.Miasto == miasto).ToList();
    }

    public void ZmienDaneOsoby(string pesel, Osoba noweDane)
    {
        var osoba = osoby.FirstOrDefault(o => o.Pesel == pesel);
        if (osoba != null)
        {
            osoba.Imie = noweDane.Imie;
            osoba.Nazwisko = noweDane.Nazwisko;
            osoba.Wiek = noweDane.Wiek;
            osoba.Wzrost = noweDane.Wzrost;
            osoba.AdresZamieszkania = noweDane.AdresZamieszkania;
        }
    }
    
    public void ZapiszJednaOsobeDoPliku(string pesel, string sciezka)
    {
        var osoba = osoby.FirstOrDefault(o => o.Pesel == pesel);
        if (osoba != null)
        {
            using (StreamWriter sw = new StreamWriter(sciezka))
            {
                sw.WriteLine($"{osoba.Id}|{osoba.Imie}|{osoba.Nazwisko}|{osoba.Wiek}|{osoba.Wzrost}|{osoba.Pesel}|{osoba.AdresZamieszkania.Miasto}|{osoba.AdresZamieszkania.KodPocztowy}|{osoba.AdresZamieszkania.NazwaUlicy}|{osoba.AdresZamieszkania.NrDomu}|{osoba.AdresZamieszkania.NrMieszkania}");
            }
        }
    }
}