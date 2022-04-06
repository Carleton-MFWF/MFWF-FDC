#include <arduino-timer.h>
#include <Servo.h> //Servo library

auto timer = timer_create_default(); // create a timer with default settings


//Pin specifications 
#define pitchpin 9 //Servo

//Variables
int timestep = 1000; 
float pitchVal; //Current pitch
float pitchCmd; // Current pitch Command
float A = 90; // amplitude (degs)
bool pulse;
//Servo names
Servo pitch;

// Serial output refresh time
const long SERIAL_REFRESH_TIME = 100;
long refresh_time;

////////////////////SETUP//////////////////////////
bool toggle_input(void *) {
  pulse = !pulse; // toggle the wave
  pitchCmd = pulse * A;
  pitch.write(pitchCmd);
  return true; // keep timer active? true
}

void setup() {


  // call the toggle_led function every 1000 millis (1 second)
  timer.every(timestep, toggle_input);
  
  Serial.begin(115200); //Higher rate

  //Servo Setup and bringing servos to 'start' position
  pitch.attach(pitchpin);

  //Servo Test (Manually input position here)
  pitch.write(0);

}

void loop() {
  timer.tick(); // tick the timer
  //Servo Actuation
  pitchVal = pitch.read();
  
  
  Serial.print("ref:\t");
  Serial.print(pitchCmd);
  Serial.print(" position:\t");
  Serial.println(pitchVal);
  delay(100);
}
