namespace ConsoleApp70;

using System;

internal class program
{
    static void Main(string[] args)
    {
        int[] tab = {1, 2, 2, 2, 3, 5, 5, 9,9, 10, 11};
        int[] bezDuplikatow = {};

        Yield nowy = new Yield();
        
        bezDuplikatow = nowy.zwrocBezDuplikatow(tab);
        
        for (int i = 0; i < bezDuplikatow.Length; i++)
        {
            Console.Write(bezDuplikatow[i] + "   ");
        }
        
    }
    

}