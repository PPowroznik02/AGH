namespace ConsoleApp70;
//Zadanie_krotki 2
public class Test_metod
{
    private long a, b, c;
    private float d;


    public long A
    {
        get { return a; }
        set { a = value; }
    }

    public long B
    {
        get { return b; }
        set { b = value; }
    }

    public long C
    {
        get { return c; }
        set { c = value; }
    }

    public float D
    {
        get { return d; }
        set { d = value; }
    }

    public Test_metod(long a, long b, long c, float d)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }
    
    public (long, long) dzielenie(long x, long y)
    {
        long wynik = x / y;
        long reszta = x % y;
        
        return (wynik, reszta);
    }

    public (long, long) potegowanie_mnozenie(long x, long y)
    {
        long potega = (long)Math.Pow(x, y);
        long mnozenie = x * y;
        
        return (mnozenie, potega);
    }
    
}