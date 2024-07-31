namespace Zadanie06_PPowroznik;

public class ZarzadzanieLiczbami
{
    private int[] tab;
    private List<int> lista;

    public List<int> Lista
    {
        get { return lista; }
        set { lista = value; }
    }

    public int[] Tab
    {
        get { return tab; }
        set { tab = value; }
    }

    public int[] stworzLosowaTablice(int rozmiar, int min, int max)
    {
        int[] tab = new int[rozmiar];
        Random r = new Random();


        for (int i = 0; i < rozmiar; i++)
        {
            tab[i] = r.Next(min, max);
        }

        this.tab = tab;
        return tab;
    }


    public List<int> zwrocNieparzyste(int[] tab)
    {
        List<int> lista = new List<int>();

        foreach (var liczba in tab)
        {
            if (liczba % 2 != 0)
            {
                lista.Add(liczba);
            }
        }

        this.lista = lista;
        return lista;
    }

    public void wypiszNieparzyste()
    {
        foreach (var liczba in this.lista)
        {
            Console.WriteLine(liczba);
        }
    }
}