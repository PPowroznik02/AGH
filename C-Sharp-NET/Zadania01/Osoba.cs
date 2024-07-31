using System;
using System.Text;

namespace ConsoleApp70;

internal class Osoba
{
    protected string imie, nazwisko, ulica, kod, miasto;
    protected int nr_ulicy;

    public string Imie
    {
        get { return imie;  }
        set { imie = value;  }
    }
    
    public string Nazwisko
    {
        get { return nazwisko;  }
        set { nazwisko = value;  }
    }
    
    public string Ulica
    {
        get { return ulica;  }
        set { ulica = value;  }
    }
    
    public string Kod
    {
        get { return kod;  }
        set { kod = value;  }
    }
    
    public string Miasto
    {
        get { return miasto;  }
        set { miasto = value;  }
    }
    
    public int Nr_ulicy
    {
        get { return nr_ulicy;  }
        set { nr_ulicy = value;  }
    }
    
    public Osoba()
    {
        imie = "";
        nazwisko = "";
        ulica = "";
        kod = "";
        miasto = "";
        nr_ulicy = 0;
    }
    public Osoba(string imie)
    {
        this.imie = imie;
        nazwisko = "";
        ulica = "";
        kod = "";
        miasto = "";
        nr_ulicy = 0;
    }
    
    public Osoba(string imie, string nazwisko)
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
        ulica = "";
        kod = "";
        miasto = "";
        nr_ulicy = 0;
    }
    
    public Osoba(string imie, string nazwisko, string ulica)
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.ulica = ulica;
        kod = "";
        miasto = "";
        nr_ulicy = 0;
    }
    
    public Osoba(string imie, string nazwisko, string ulica, string kod) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.ulica = ulica;
        this.kod = kod;
        miasto = "";
        nr_ulicy = 0;
    }
    
    public Osoba(string imie, string nazwisko, string ulica, string kod, string miasto) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.ulica = ulica;
        this.kod = kod;
        this.miasto = miasto;
        nr_ulicy = 0;
    }
    
    public Osoba(string imie, string nazwisko, string ulica, string kod, string miasto, int nr_ulicy) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
        this.ulica = ulica;
        this.kod = kod;
        this.miasto = miasto;
        this.nr_ulicy = nr_ulicy;
    }

    public virtual void wczytaj()
    {
        Console.WriteLine("Podaj imie");
        this.imie = Console.ReadLine();
        
        Console.WriteLine("Podaj nazwisko");
        this.nazwisko = Console.ReadLine();
        
        Console.WriteLine("Podaj ulice");
        this.ulica = Console.ReadLine();
        
        Console.WriteLine("Podaj kod");
        this.kod = Console.ReadLine();
        
        Console.WriteLine("Podaj miasto");
        this.miasto = Console.ReadLine();
        
        Console.WriteLine("Podaj nr ulicy");
        this.nr_ulicy = Convert.ToInt32(Console.ReadLine());
        
    }

    public virtual void wypisz()
    {
        Console.WriteLine("Imie: " + imie);
        Console.WriteLine("Nazwisko: " + nazwisko);
        Console.WriteLine("Ulica: " + ulica);
        Console.WriteLine("Kod: " + kod);
        Console.WriteLine("Miasto: " + miasto);
        Console.WriteLine("Nr ulicy: " + nr_ulicy);
        

    }
    

}