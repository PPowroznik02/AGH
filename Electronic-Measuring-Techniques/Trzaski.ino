void setup() {
Serial.begin(9600);
pinMode(A5,INPUT);
pinMode(LED_BUILTIN, OUTPUT);
}

float t1=micros();
int k=0;
long int sum=0, avg=0, r;

void loop() {

  for (int i=0; i<1000; i++){
    sum += abs(analogRead(A5));
    while (micros()<t1+250){}
    t1=micros();
  }

  avg = sum/1000;
  Serial.print("wartosc srednia: ");
  Serial.println(avg);


  digitalWrite(LED_BUILTIN, LOW); 
  for(int i=0; i<1000; i++){
    r = analogRead(A5);
    if(r>3*avg){
      digitalWrite(LED_BUILTIN, HIGH);
      Serial.println("###Trzask###");
      Serial.print("Wartosc trzasku: ");
      Serial.println(r); 
      break;      
      } 
      while (micros()<t1+250){}
    t1=micros();   
  }


  t1=micros();
  sum=0;
  k=0;
  avg=0;
}
