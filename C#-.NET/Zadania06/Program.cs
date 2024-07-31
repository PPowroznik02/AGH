namespace Zadanie06_PPowroznik

{
    internal class Program
    {
        static void Main(string[] args)
        {
            ZarzadzanieLiczbami nowa = new ZarzadzanieLiczbami();

            int[] tablica = nowa.stworzLosowaTablice(20, 1, 90);

            List<int> nieparzyste = nowa.zwrocNieparzyste(tablica);

            Console.WriteLine("-----------------");
            nowa.wypiszNieparzyste();

            Singleton singleton = Singleton.Instance();
            
            singleton.deleteGreaterThanMax(nowa.Lista, 30);
            
            Console.WriteLine("-----------------");
            nowa.wypiszNieparzyste();
        }
    }
}