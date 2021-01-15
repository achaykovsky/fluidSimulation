class Particle
{
    int index = 0;
    float r;
    PVector position = new PVector(600,180);
    float xVelocity = 0.2;
    float yVelocity = 0.4;
    float dXVelocity = 0;
    float dYVelocity = 0;
    float mass;
    float density;
    float viscosity;
    float pressure;
    color colour;
    float restDensity;
    PVector dVelocity = new PVector(0,0);
    float dt;
  
  //c'tor for the update from GUI option
  Particle(float _xPos, float _yPos, float _mass, float _restDensity)
  {
    this.position.x = _xPos;
    this.position.y = _yPos;
    this.colour = color(30,193,250);
    this.mass = _mass;
    this.restDensity = _restDensity;
    //this.viscosity = _viscosity;
    this.density = 0;
    this.pressure = 0;
  }

  //empty c'tor
  Particle()
  {
    this.position.x = 0;
    this.position.y = 0;
    this.mass = 0;
    this.viscosity = 0;
    this.density = 0;
    this.pressure = 0;
    this.yVelocity = 0.1;
    this.xVelocity= 0.2;
  }
  
  //copy c'tor
  Particle(Particle particle) 
  {
    this.position.x = particle.position.x;
    this.position.y = particle.position.y;
    this.colour = particle.colour;
    this.mass = particle.mass;
    this.restDensity = particle.restDensity;
    this.viscosity = particle.viscosity;
    this.yVelocity = particle.yVelocity;
    this.xVelocity = particle.xVelocity;
    this.density = particle.density;
    this.pressure = particle.pressure;
   }
  
  
      void display(float h) 
      {
      fill(30,193,250);
      circle(position.x, position.y, h*10);
      stroke(0,0,0);
      } 

    //getters
    float getXPos()
    {
      return position.x;
    }
    
    float getYPos() 
    {
      return position.y;
    }
    
    float getMass()
    {
      return mass;
    }
    
    float getViscosity()
    {
      return viscosity;
    }
    
    int getIndex()
    {
      return index;
    }

    float getDensity()
    {
      return density;
    }
    
    float getPressure()
    {
      return pressure;
    }
    
    float getXVelocity() 
    {
      return xVelocity;
    }
    
    float getYVelocity() 
    {
      return yVelocity;
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
    
    void setYVelocity(float _yVelocity) 
    {
      yVelocity = _yVelocity;
    }
    
    void setXVelocity(float _xVelocity) 
    {
      xVelocity = _xVelocity;
    }
  
    //rest density will be updated from the GUI
    void setPressure() 
    {
      pressure = k * (density - restDensity);
    }
  
    float addDensity(float _density) 
    {
      this.density += _density;
      return density;
    }
    
    void setIndex(int _index) 
    {
      index = _index;
    }


//functions to update the velocity, using acceleration

    //updates the acceleration by x and y
    PVector accelerate(float xForce, float yForce) 
    {
      dVelocity.x += xForce / density;
      dVelocity.y += yForce / density;
      return dVelocity;
    }
    
    //updates the velocity using x and y
    void updateVelocity(float dt) 
    {
      xVelocity += dVelocity.x * dt;
      yVelocity += dVelocity.y * dt;
      
      position.x += xVelocity * dt;
      position.y += yVelocity * dt;
      
      
      dVelocity.set(0,0);
    
      density = 0;
      pressure = 0;
    }
  
}
