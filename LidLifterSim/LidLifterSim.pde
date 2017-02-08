
Lid lid;

void setup(){
  size(1800,900);
  lid = new Lid();
  fill(255);
  stroke(0);
}

final float endAngle = radians(-120),
            startAngle = 0,
            accelInc = 0.0002;
            
float accel = 0.001,
      dt = 0.5,
      a = accel,
      currentSpeed = 0,
      direction = -1,
      alpha = 0;;

void draw(){
  background(0);
  pushMatrix();
  translate(width/2.0, height-50);
  translate(-lid.wid/2.0,0);
  rotate(alpha);
  translate(lid.wid/2.0,0);
  lid.display();
  updateDirection();
  updateAngle();
  popMatrix();
  text("Angle: " + round(degrees(alpha)), 100,100);
  text("Acceleration: " + nf(accel,1,5), 100,120);
}

void updateAngle(){
  if (currentSpeed <= 0 && alpha < endAngle/2.0){
    a = accel;
  }
  if (currentSpeed >= 0 && alpha > endAngle/2.0){
    a = -accel;
  }
  alpha = min(max(endAngle,alpha + 0.5*a*dt*dt + currentSpeed*dt),startAngle);
  currentSpeed += a*dt;
  
}
void updateDirection(){
  if(degrees(alpha) <= -120){
    direction = 1;
  }
  else if (degrees(alpha) >= 0){
      direction = -1;
  }
}
void reset(){
   a = accel;
      currentSpeed = 0;
      direction = -1;
      alpha = 0;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    accel += accelInc;
  } else if (mouseButton == RIGHT) {
    accel -= accelInc;
  }
  reset();
}

class Lid{
  
  float wid = 500,
        het =  20;
        
   Lid(){}
   void display(){
     rect(0,0,wid,het);
   }
}