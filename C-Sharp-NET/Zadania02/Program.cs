using Zadania02_PPowroznik;

namespace ConsoleApp70;

internal class program
{
    static void Main(string[] args)
    {
        //Zadanie_struktury
        /*
        Ulamek nowyUlamek = new Ulamek(8, 10);
        nowyUlamek.uprosc();
        Console.WriteLine(nowyUlamek.Licznik);
        Console.WriteLine(nowyUlamek.Mianownik);

        Ulamek nowyUlamek2 = new Ulamek(64, 4);
        nowyUlamek2.uprosc();
        Console.WriteLine(nowyUlamek2.Licznik);
        Console.WriteLine(nowyUlamek2.Mianownik);
        */


        //Zad1
        /*
        int rozmiar;
        Random random = new Random();
        Console.Write("Podaj ilość par: ");
        rozmiar = int.Parse(Console.ReadLine());
        if (rozmiar > 0)
        {
            Para<int, long>[] tablica_par = new Para<int, long>[rozmiar];
            for (int i = 0; i < tablica_par.Length; i++)
            {
                tablica_par[i] = new Para<int, long>(random.Next(20), random.Next(20));
            }

            foreach (var paraka in tablica_par)
            {
                Console.WriteLine(paraka.ToString());
            }
        }
        */
        
        //Zad2
        /*
        GenerycznyStos<int> nowyStos = new GenerycznyStos<int>();
        Console.WriteLine("Elementy na stosie");
        nowyStos.Numbers.Push(1);
        nowyStos.Numbers.Push(2);
        nowyStos.Numbers.Push(3);
        
        foreach (int element in nowyStos.Numbers)
        {
            Console.WriteLine(element);
        }

        nowyStos.Numbers.Pop();
        Console.WriteLine("Rozmiar: " + nowyStos.Numbers.Count);
        */
        
        //Zad3
        GenerycznaTablica<int> nowaTablica = new GenerycznaTablica<int>(5);
        
        nowaTablica.ustawWartosc(4,0);
        nowaTablica.ustawWartosc(4,1);
        nowaTablica.ustawWartosc(2,2);

        Console.WriteLine("Wartosci tablicy");
        Console.WriteLine(nowaTablica.pobierzWartosc(0));
        Console.WriteLine(nowaTablica.pobierzWartosc(1));

    }
}