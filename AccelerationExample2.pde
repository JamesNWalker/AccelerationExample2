//based on 'Acceleration with Vectors' by Daniel Shiffman

// A Mover object
Mover mover;

void setup() {
  background(255);
  size(640, 360);
  mover = new Mover(new PVector(width/2, height/2), -80, 4.0);
  frameRate(30);
}

void draw() {
  noStroke();
  fill(255);
  rectMode(CORNER);
  rect(0,0,width,height);
  // Update the location
  mover.update();
  // Display the Mover
  mover.display();
}

class Mover  {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector centre;
  PVector arm;
  float topspeed;
  
  Mover (PVector _centre, float _radius, float _topspeed)  {
    topspeed = _topspeed;
    centre = _centre;
    arm = new PVector(0, _radius);
    location = PVector.add(centre, arm);
    velocity = new PVector(topspeed, 0);
  }
  
  void update()  {
    acceleration = PVector.sub(centre, location);
    acceleration.setMag(velocity.magSq()/arm.mag());
    velocity.add(acceleration);
    // Location changes by velocity
    location.add(velocity);
    // Limit velocity by top speed
    velocity.limit(topspeed);
  }
  
  void display() {
    stroke(0);
    float k = 25;  // arrow length
    float r = 4.0; // arrow head size
    
    // Draw an arrow pointing in the direction of travel
    float theta = velocity.heading() + radians(90);
    
    pushMatrix();
    translate(location.x, location.y);
    
    // Draw ball
    fill(0, 0, 255);
    ellipse(0, 0, 10, 10);
    
    // Draw arrow
    rotate(theta);
    line(0, 0, 0, -k);
    translate(0, -k);
    fill(255, 0, 0);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    popMatrix();
    
    // Draw an arrow pointing in the direction of acceleration
    float alpha = acceleration.heading() + radians(90);
    
    pushMatrix();
    translate(location.x, location.y);
    
    // Draw arrow
    rotate(alpha);
    line(0, 0, 0, -k);
    translate(0, -k);
    fill(255, 255, 0, 128);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    
    popMatrix();
  }
}