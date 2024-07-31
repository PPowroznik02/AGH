namespace ConsoleApp70;


internal class program
{
    
    public delegate bool Kryterium(int zmienna);
    
    static void Main(string[] args)
    {
        Console.WriteLine("Podaj rozmiar");
        int rozmiar = Convert.ToInt32(Console.ReadLine());
        int[] tab = new int[rozmiar];
        int szukana, p1, p2;

        Random rnd = new Random();

        for (int i = 0; i < rozmiar; i++)
        {
            tab[i] = rnd.Next(1, 20);
        }

        for (int i = 0; i < rozmiar; i++)
        {
            Console.Write(tab[i] + "   ");
        }
        
        Console.WriteLine();
        Console.WriteLine("Podaj szukana liczbe");
        szukana = Convert.ToInt32(Console.ReadLine());

        int zliczenie = Zlicz(tab, x => x == szukana);
        
        Console.WriteLine("Ilosc wystapien: " + zliczenie);
        
        Console.WriteLine("Podaj przedzial szukania (min, max)");
        p1 = Convert.ToInt32(Console.ReadLine());
        p2 = Convert.ToInt32(Console.ReadLine());
        int zliczenie2 = Zlicz(tab, x => x >= p1 && x <= p2);
        
        Console.WriteLine("Ilosc wystapien: " + zliczenie2);

    }
    
    static int Zlicz(int[] tab, Kryterium kryterium)
    {
        int ilosc = 0;
        
        for (int i = 0; i < tab.Length; i++)
        {
            if (kryterium(tab[i]))
            {
                ilosc++;
            }
        }

        return ilosc;
    }

}
