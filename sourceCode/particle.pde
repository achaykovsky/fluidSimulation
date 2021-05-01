class Particle
{
    int index;
    float r;
    PVector position = new PVector(1150,180);   
    PVector velocity = new PVector (0.1,0.2);
    PVector gravAcceleration = new PVector (0.0, 9.8);
    PVector gravity = new PVector (0.0, 0.0);
    PVector surfaceTension = new PVector(0,0);
    PVector viscosity = new PVector(0,0);
    PVector pressureForce = new PVector(0,0);
    PVector totalForce = new PVector(0,0);
    PVector dVelocity = new PVector(0,0);
    color colour = color(30,193,250);
    float pressure;
    float scale;
    float mass;
    float density;
    float restDensity;
  
  //c'tor for the update from GUI option
  Particle(float _xPos, float _yPos, float _mass, float _restDensity)
  {
    this.position.set(_xPos,_yPos);
    this.dVelocity.set(0,0);
    this.velocity.set(0.1,0.2);
    this.colour = color(30,193,250);
    this.pressureForce.set(0,0);
    this.mass = _mass;
    this.restDensity = _restDensity;
    this.density = 0;
  }

  //empty c'tor
  Particle()
  {
    this.position.set(600,180);
    this.velocity.set(0,0);
    this.colour = color(30,193,250);
    this.mass = 0;
    this.density = 0;
    this.pressureForce.set(0,0);
  }
  
  //copy c'tor
  Particle(Particle particle) 
  {
    this.position = particle.position;
    this.pressure = particle.pressure;
    this.velocity = particle.velocity;
    this.colour = particle.colour;
    this.mass = particle.mass;
    this.restDensity = particle.restDensity;
    this.density = particle.density;
    this.pressureForce = particle.pressureForce;
   }
  
    void display(float h, int index) 
    {
       float scale;
       scale = h * height * 0.01;
       fill(colour);
       //noStroke();
       circle(position.x, position.y, scale);
       //text(index, position.x, position.y);
       
       fill(#FF8103);//orange
       line(position.x, position.y, position.x + surfaceTension.x, position.y + surfaceTension.y);
       //fill(#FF8103);//orange
       text("ST", position.x + surfaceTension.x, position.y + surfaceTension.y);
       
       fill(#0308FF);//blue
       line(position.x, position.y, position.x + gravity.x, position.y + gravity.y);
       //fill(#0308FF);//blue
       text("g", position.x + gravity.x, position.y + gravity.y);
       
       fill(#FF0346);//red
       text("v",  position.x + viscosity.x, position.y + viscosity.y);
       line(position.x, position.y, position.x + viscosity.x, position.y + viscosity.y);
       //fill(#FF0346);//red
       //text("v",  position.x + viscosity.x, position.y + viscosity.y);
       
       fill(#006429);//green
       line(position.x, position.y, position.x + pressureForce.x, position.y + pressureForce.y);
       //fill(#006429);//green
       text("p", position.x + pressureForce.x, position.y + pressureForce.y);
    }
    

    //getters
    PVector getPos()
    {
      return position;
    }
    
    float getMass()
    {
      return mass;
    }
    
    int getIndex()
    {
      return index;
    }

    float getDensity()
    {
      return density;
    }
    
    PVector getPressureForce()
    {
      return pressureForce;
    }
    float getPressure()
    {
      return pressure;
    }
    
    PVector getVelocity() 
    {
      return velocity;
    }
    
    
    
    //setters
    void setX(float _xPos) 
    {
      position.x = _xPos;
    }
    
    void setY(float _yPos) 
    {
      position.y = _yPos;
    }
    
    void setMass(float _mass)
    {
      mass = _mass;
    }
    
    void setDensity(float _density)
    {
      density = _density;
    }
    
    void setXVelocity(float _xVelocity) 
    {
      velocity.x = _xVelocity;
    }
    
    void setYVelocity(float _yVelocity) 
    {
      velocity.y = _yVelocity;
    }
    
  
    //rest density will be updated from the GUI
    void setPressure() 
    {
      pressure = k * (density - restDensity);
    }
  
    void addDensity(float _density) 
    {
      this.density += _density;
    }
    
    void setIndex(int _index) 
    {
      index = _index;
    }
   



//functions to update the velocity, using acceleration

    //updates the acceleration by x and y
    void accelerate(float xForce, float yForce) 
    {
      if (density != 0)
      {
        dVelocity.x += xForce / density;
        dVelocity.y += yForce / density;
      }
    }
    
    //updates the velocity using x and y
    void updateVelocity(float dt) 
    {
      //updating the velocity
      velocity.x += dVelocity.x * dt;
      velocity.y += dVelocity.y * dt;
      
      //updating the position
      position.x += velocity.x * dt;
      position.y += velocity.y * dt;
      
      //initialzing params for the next iteration
      dVelocity.set(0,0);
      density = 0;
      pressure = 0;
    }
    
}
