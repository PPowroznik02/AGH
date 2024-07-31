namespace ConsoleApp70;
//Zadanie_krotki 1 
public class Krotki
{
    private int n; 
    private (string nazwisko, string imie, int nr_id)[] tablica_krotek;
    
    public Krotki(int n)
    {
        this.n = n;
        this.tablica_krotek = new (string nazwisko, string imie, int nr_id)[n];

        for (int i = 0; i < n; i++)
        {
            Console.WriteLine("Podaj nazwisko: ");
            this.tablica_krotek[i].nazwisko = Console.ReadLine();
            Console.WriteLine("Podaj imie: ");
            this.tablica_krotek[i].imie = Console.ReadLine();
            this.tablica_krotek[i].nr_id = n;
        }
        
    }

    public void wypisz()
    {
        for (int i = 0; i < n; i++)
        {
            Console.WriteLine("Nazwisko: " + tablica_krotek[i].nazwisko + " Imie: " + tablica_krotek[i].imie + " Id: " + tablica_krotek[i].nr_id);
        }
    }
}