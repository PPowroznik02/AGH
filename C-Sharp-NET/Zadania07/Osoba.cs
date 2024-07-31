namespace Zadanie07_PPowroznik;

public class Osoba
{
    public int Id { get; set; }
    public string Imie { get; set; }
    public string Nazwisko { get; set; }
    public int Wiek { get; set; }
    public int Wzrost { get; set; }
    public string Pesel { get; set; }
    public Adres AdresZamieszkania { get; set; }

    public override string ToString()
    {
        return $"{Imie} {Nazwisko}, Wiek: {Wiek}, Wzrost: {Wzrost} cm, PESEL: {Pesel}, Adres: {AdresZamieszkania}";
    }
}