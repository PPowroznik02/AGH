namespace Zadanie06_PPowroznik;

public class Singleton
{
    static Singleton instance;
    protected Singleton()
    {
    }
    public static Singleton Instance()
    {
        if (instance == null)
        {
            instance = new Singleton();
        }
        return instance;
    }
    
    public void deleteGreaterThanMax(List<int> lista, int max)
    {
        lista.RemoveAll(x => x > max);
    }
}