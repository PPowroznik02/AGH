namespace Zadania04_PPowroznik;

public class Iteratory
{
    public int[] tab;
    protected List<int> listaNieparzystych;

    public Iteratory()
    {
        
    }
    
    public Iteratory(int rozmiar)
    {
        tab = new int[rozmiar];
        listaNieparzystych = new List<int>();
        
        Random rnd = new Random();

        for (int i = 0; i < rozmiar; i++)
        {
            tab[i] = rnd.Next(1, 20);
        }
    }

    public List<int> tylkoNieparzyste(int[] tab)
    {
        for (int i = 0; i < tab.Length; i++)
        {
            if (tab[i] % 2 != 0)
            {
                this.listaNieparzystych.Add(tab[i]);   
            }
        }
        
        return this.listaNieparzystych;
    }

    public int zliczNieparzyste()
    {
        int ilosc = 0;
        
        IEnumerator<int> iterator = listaNieparzystych.GetEnumerator();
        while (iterator.MoveNext())
        {
            ilosc++;
        }
        
        return ilosc;
    }

    public void wypiszListe()
    {
        Console.WriteLine();
        foreach (int e in this.listaNieparzystych)
        {
            Console.Write(e + "   ");
        }
    }
    
    public void wypiszTablice()
    {
        for (int i = 0; i < tab.Length; i++)
        {
            Console.Write(tab[i] + "   ");
        }
    }
    
    public void uruchom()
    {
        
    }
}