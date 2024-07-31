namespace Zadanie07_PPowroznik;

public class Adres
{
    public string Miasto { get; set; }
    public string KodPocztowy { get; set; }
    public string NazwaUlicy { get; set; }
    public int NrDomu { get; set; }
    public int NrMieszkania { get; set; }

    public override string ToString()
    {
        return $"{NazwaUlicy} {NrDomu}/{NrMieszkania}, {KodPocztowy} {Miasto}";
    }
}