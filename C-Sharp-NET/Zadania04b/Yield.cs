namespace ConsoleApp70;

public class Yield
{
    protected List<int> listaBezDuplikatow;

    public Yield()
    {
        listaBezDuplikatow = new List<int>();
    }

    private  IEnumerable<int> usunaDuplikaty(int[] array)
    {
        HashSet<int> seen = new HashSet<int>();
        foreach (int value in array)
        {
            if (seen.Add(value))
            {
                yield return value;
            }
        }
    }

    public int[] zwrocBezDuplikatow(int[] tab)
    {
        int[] bezDuplikatow = { };
        foreach (int value in this.usunaDuplikaty(tab)) {
            dodajDoTablicy(ref bezDuplikatow, value);
        }

        return bezDuplikatow;
    }

    private void dodajDoTablicy(ref int[] tab, int newValue) {
        Array.Resize(ref tab, tab.Length + 1);
        tab[tab.Length - 1] = newValue; 
    }
}