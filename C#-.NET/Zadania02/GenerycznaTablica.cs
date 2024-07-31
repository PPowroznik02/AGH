namespace Zadania02_PPowroznik;

public class GenerycznaTablica<T>
{
    private T[] tablica;

    public T[] Tablica
    {
        get => tablica;
        set => tablica = value ?? throw new ArgumentNullException(nameof(value));
    }

    public GenerycznaTablica(int n)
    {
        tablica = new T[n];
    }

    public T pobierzWartosc(int index)
    {
        return tablica[index];
    }

    public void ustawWartosc(T var, int index)
    {
        if (index <= tablica.Count())
        {
            tablica[index] = var;
        }
    }
}