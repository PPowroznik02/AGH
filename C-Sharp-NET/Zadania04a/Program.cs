using Zadania04_PPowroznik;

namespace ConsoleApp70;

internal class program
{
    static void Main(string[] args)
    {
        List<int> lista;
        int iloscNieparzystych;
        
        Iteratory nowy = new Iteratory(20);
        nowy.wypiszTablice();
        
        lista = nowy.tylkoNieparzyste(nowy.tab);
        nowy.wypiszListe();

        iloscNieparzystych = nowy.zliczNieparzyste();
        
        Console.WriteLine();
        Console.WriteLine("Na liscie jest: " + iloscNieparzystych + " liczb nieparzytych");
    }
}