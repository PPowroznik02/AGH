
namespace ConsoleApp70
{
    internal class Para<T, D>
    {
        private T pierwsza = default(T);
        private D druga = default(D);
        

        public Para(T pierwszy, D drugi)
        {
            pierwsza = pierwszy;
            druga = drugi;
        }
        

        public override string ToString()
        {
            return pierwsza.ToString() + "\t" + druga.ToString();
        }
    }
}