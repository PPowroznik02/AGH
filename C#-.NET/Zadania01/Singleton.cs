namespace ConsoleApp70;

public sealed class Singleton
{
    private static Singleton _instancja = null;
    private Singleton() { }

    public static Singleton Instancja()
    {
        if (_instancja == null)
        {
            _instancja = new Singleton();
        }
        return _instancja;
    }
    
}