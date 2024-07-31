namespace TypyO_czw1;

public struct Ulamek
{
    private int licznik, mianownik;

    public int Licznik
    {
        get { return licznik; }
        set { licznik = value;  }
    }

    public int Mianownik
    {
        get { return mianownik; }
        set { mianownik = value;  }
    }

    public Ulamek(int licznik, int mianownik)
    {
        this.mianownik = mianownik;
        this.licznik = licznik;
    }

    public int NWD(int a, int b)
    {
        int nwd = 1;
        List<int> dzielnikiA = new List<int>();
        List<int> dzielnikiB = new List<int>();

        int d = 2;
        while (a != 1)
        {
            
            if (a % d == 0)
            {
                dzielnikiA.Add(d);
                a /= d;
                d = 2;
            }
            else
            {
                d++;
            }
        }
        
        d = 2;
        while (b != 1)
        {        

            if (b % d == 0)
            {
                dzielnikiB.Add(d);
                b /= d;
                d = 2;
            }
            else
            {
                d++;
            }
        }
        
        for (int i = 0; i < dzielnikiA.Count; i++)
        {
            for (int j = 0; j < dzielnikiB.Count; j++)
            {
                if (dzielnikiA[i] == dzielnikiB[j])
                {
                    nwd *= dzielnikiA[i];
                    dzielnikiB.RemoveAt(j);
                    break;
                }
            }
        }
        
        return nwd;
    }

    public void uprosc()
    {
        int dzielnik = NWD(licznik, mianownik);
        
        licznik /= dzielnik;
        mianownik /=  dzielnik;
    }
    
}