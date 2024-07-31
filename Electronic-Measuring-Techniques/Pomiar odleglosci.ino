#include <LiquidCrystal.h>
#include <LiquidCrystal.h>


const int rs = 8, en = 9, d4 = 4, d5 = 5, d6 = 6, d7 = 7, bcl = 10;
const int b1=719, b2=478, b3=132, b4=306, b5=0;

LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

unsigned long duration;

int analogPin = A0;
int val = 0;
int trig = A2;
int echo = A3;
int w, k;

void setup() {

  Serial.begin(9600);
  lcd.begin(16, 2);

  pinMode(bcl, OUTPUT);  
  pinMode(A2, OUTPUT);
  pinMode(A3, INPUT);
}

void wyswietl(){
  digitalWrite(bcl,LOW);
  if(val >= b1-20 && val <= b1+20)  lcd.print("#");
  else if(val >= b2-20 && val <= b2+20)  lcd.print("$");
  else if(val >= b3-20 && val <= b3+20)  lcd.print("%");
  else if(val >= b4-20 && val <= b4+20)  lcd.print("&");
  else if(val >= b5-20 && val <= b5+20)  lcd.print("Krzak");
  lcd.print("                 ");
}


void przesun(){
  if(val >= b2-20 && val <= b2+20){  
    if(k==0) k=15;
    else k--;
  }
  else if(val >= b3-20 && val <= b3+20){
    if(w==0) w=1;
    else w=0;
  }
  else if(val >= b4-20 && val <= b4+20){ 
    if(w==1) w=0;
    else w=1;
  }
  else if(val >= b5-20 && val <= b5+20){
    if(k==15)  k=0;
    else k++;  
  }
  lcd.clear();
  lcd.setCursor(k, w);
  lcd.print("*");
  delay(50);
  
}
int czas;




void loop() {

  digitalWrite(bcl, HIGH);

  digitalWrite(A2, LOW);
  delayMicroseconds(2);
  digitalWrite(A2, HIGH);
  delayMicroseconds(10);
  digitalWrite(A2, LOW);

  czas = pulseIn(A3, HIGH);
  lcd.setCursor(0, 0);

  lcd.print(czas/58);
  delay(200);

  lcd.clear();

}