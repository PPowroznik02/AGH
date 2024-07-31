namespace Zadania02_PPowroznik;

public class GenerycznyStos<T>
{
    private Stack<T> numbers = new Stack<T>();
    
    public Stack<T> Numbers
    {
        get { return numbers; }
        set { numbers = value;  }
    }

    public GenerycznyStos()
    {
        
    }
}