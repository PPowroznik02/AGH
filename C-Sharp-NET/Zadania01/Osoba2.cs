using System;
using System.Text;

namespace ConsoleApp70;

internal class Osoba2
{
    protected string imie, nazwisko;
    protected List<Dane_Adrr> adresy = new List<Dane_Adrr>();

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
    
 
    
    public Osoba2()
    {
        imie = "";
        nazwisko = "";
    }
    public Osoba2(string imie)
    {
        this.imie = imie;
        nazwisko = "";
    }
    
    public Osoba2(string imie, string nazwisko)
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
    }
    
    public Osoba2(string imie, string nazwisko, string ulica)
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
    }
    
    public Osoba2(string imie, string nazwisko, string ulica, string kod) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
    }
    
    public Osoba2(string imie, string nazwisko, string ulica, string kod, string miasto) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;

    }
    
    public Osoba2(string imie, string nazwisko, string ulica, string kod, string miasto, int nr_ulicy) 
    {
        this.imie = imie;
        this.nazwisko = nazwisko;
    }
    
    public class Dane_Adrr
    {
        
        protected string ulica, kod, miasto, nazwa;
        protected int nr_ulicy, nr_mieszkania;
        
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
        
        public string Nazwa
        {
            get { return nazwa;  }
            set { nazwa = value;  }
        }
        
        public int Nr_mieszkania
        {
            get { return nr_mieszkania;  }
            set { nr_mieszkania = value;  }
        }
        
        public Dane_Adrr(string ulica, string kod, string miasto, int nr_ulicy, int nr_mieszkania, string nazwa)
        {
            this.Ulica = ulica;
            this.Kod = kod;
            this.Miasto = miasto;
            this.nr_ulicy = nr_ulicy;
            this.nr_mieszkania = nr_mieszkania;
            this.nazwa = nazwa;
        }

        public void wypisz_dane()
        {
            Console.WriteLine("Ulica: " + ulica);
            Console.WriteLine("Kod: " + kod);
            Console.WriteLine("Miasto: " + miasto);
            Console.WriteLine("Nr ulicy: " + nr_ulicy);
            Console.WriteLine("Nr mieszkania: " + nr_mieszkania);
            Console.WriteLine("--------------------");
        }
        
    }
    
    public void DodajAdres(string ulica, string kod, string miasto, int nr_ulicy, int nr_mieszkania, string nazwa)
    {
        adresy.Add(new Dane_Adrr(ulica, kod, miasto, nr_ulicy, nr_mieszkania, nazwa));
    }
    
    
    public void wyswietl_adresy()
    {
        foreach (var a in adresy)
        {
            a.wypisz_dane();
        }
    }

    public virtual void wczytaj()
    {
        Console.WriteLine("Podaj imie");
        this.imie = Console.ReadLine();
        
        Console.WriteLine("Podaj nazwisko");
        this.nazwisko = Console.ReadLine();
        

        
    }

    public virtual void wypisz()
    {
        Console.WriteLine("Imie: " + imie);
        Console.WriteLine("Nazwisko: " + nazwisko);

        
    }
    

}