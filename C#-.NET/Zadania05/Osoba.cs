using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace czwartek_d_Linq
{
    internal class Osoba
    {
        private string imie;
        private string nazwisko;
        private int wiek;
        private int id;
        private string nrTelefonu;
        private string pesel;
        private string wykształcenie;

        public string Imie
        {
            get { return imie; }
            set { imie = value; }
        }

        public string Nazwisko
        {
            get { return nazwisko; }
            set { nazwisko = value; }
        }

        public int Wiek
        {
            get { return wiek; }
            set { wiek = value; }
        }

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public string NrTelefonu
        {
            get { return nrTelefonu; }
            set { nrTelefonu = value; }
        }

        public string Pesel
        {
            get { return pesel; }
            set { pesel = value; }
        }

        public string Wykształcenie
        {
            get { return wykształcenie; }
            set { wykształcenie = value; }
        }

        public override string ToString()
        {
            return Id.ToString() + "; " + Imie + " " + Nazwisko + "; " + Wiek + "; " + NrTelefonu + "; " + Pesel +
                   "; " + Wykształcenie;
        }
    }
}