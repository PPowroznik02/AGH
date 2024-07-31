int L[4] = {2,3,4,5};
int R[4] = {6,7,8,9};

void setup() {
  for(int k=0; k<4; k++){
    pinMode(L[k], INPUT_PULLUP);
    pinMode(R[k], OUTPUT);
    digitalWrite(R[k],HIGH);
  } 
  Serial.begin(9600);
  
}

int oldkey = 0;

void loop() {
  int key=0;
  for(int w=0; w<4; w++){

    digitalWrite(R[w],LOW);
    for(int k=0; k<4; k++){
      if(digitalRead(L[k]) == LOW){
        key = k + 4*w + 1;
      }
    }
    digitalWrite(R[w],HIGH);   
  }

  if(oldkey != key){
    if(key > 0)
      Serial.println(key);
    oldkey = key;
  }
  delay(30);

}
