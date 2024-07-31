using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace plikowe
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //DoPliku nowy = new DoPliku();
            //nowy.pobierzDane();
            //nowy.zapiszDoPliku();
            //nowy.czytajZPliku();
            //TestyXml testy = new TestyXml();
            //testy.ZapiszXml();

            string dbName = "osoby.db";
            if(File.Exists(dbName))
            {
                File.Delete(dbName);
            }
            ZapisBazy bazaDanych = new ZapisBazy();
            Console.WriteLine("Dodanie rekordów do bazy danych:");
            TestyBazy nowa = new TestyBazy();
            nowa.dodajOsoby(bazaDanych);
            nowa.pokazBaze(bazaDanych);
        }
    }
}
