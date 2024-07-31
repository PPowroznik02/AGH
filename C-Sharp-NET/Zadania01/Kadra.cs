using System;

namespace ConsoleApp70;

internal class Kadra : Osoba
{
    private string wyksztalcenie, stanowisko, pesel;
    
    public string Wyksztalcenie
    {
        get { return wyksztalcenie;  }
        set { wyksztalcenie = value;  }
    }

    public string Stanowisko
    {
        get { return stanowisko;  }
        set { stanowisko = value;  }
    }

    public string Pesel
    {
        get { return pesel;  }
        set { pesel = value;  }
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
        
        Console.WriteLine("Podaj wyksztalcenie");
        this.wyksztalcenie = Console.ReadLine();
        
        Console.WriteLine("Podaj stanowisko");
        this.stanowisko = Console.ReadLine();
        
        Console.WriteLine("Podaj pesel");
        this.pesel = Console.ReadLine();
        
    }

    public virtual void wypisz()
    {
        Console.WriteLine("Imie: " + imie);
        Console.WriteLine("Nazwisko: " + nazwisko);
        Console.WriteLine("Ulica: " + ulica);
        Console.WriteLine("Kod: " + kod);
        Console.WriteLine("Miasto: " + miasto);
        Console.WriteLine("Nr ulicy: " + nr_ulicy);
        Console.WriteLine("Wyksztalcenie: " + Wyksztalcenie);
        Console.WriteLine("Stanowisko: " + Stanowisko);
        Console.WriteLine("Pesel: " + Pesel);
        

    }

    public bool test_pesel()
    {
        
        if (pesel.Length == 11)
        {
            return true;
        }
        else
        {
            return false;
        }
    }


}