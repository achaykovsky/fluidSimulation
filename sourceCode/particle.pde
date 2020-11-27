class Particle
{
    float r;
    float xPos;
    float yPos;
    float prevVelocity = 0;
    float velocity;
    float mass;
    float density;
    float viscosity;
    float k; //fluid constant
    float fluidViscosity;// s
    float pressure;
    color colour;
    float restDensity;
    float dXforce = 0;
    float dYforce = 0;
    float xForce = 0;
    float yForce = 0;
    float x;
    float y;
  
  
  Particle(float _xPos, float _yPos, float _mass, float _viscosity, float _k)
  {
    this.xPos = _xPos;
    this.yPos = _yPos;
    this.colour = color(0,0,0);
    this.mass = _mass;
    this.viscosity = _viscosity;
    this.density = 0;
    this.pressure = 0;
    this.k = _k;
    //this.velocity = _velocity;
    //this.prevVelocity = _prevVelocity;
  }

  //empty c'tor
  Particle()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.mass = 0;
    this.viscosity = 0;
    this.density = 0;
    this.pressure = 0;
    this.density = 0;
  }

    //getters
    float getXPos()
    {
      return xPos;
    }
    
    float getYPos() 
    {
      return yPos;
    }
    
    float getMass()
    {
      return mass;
    }
    
    float getViscosity()
    {
      return viscosity;
    }
    
    float getDensity()
    {
      return density;
    }
    
    float getPressure()
    {
      return pressure;
    }
    
    float getVelocity() 
    {
      return velocity;
    }
    
    float getPrevVelocity() 
    {
      return velocity;
    }
    
    
    //setters
    void setX(float _xPos) 
    {
      xPos = _xPos;
    }
    
    void setY(float _yPos) 
    {
      yPos = _yPos;
    }
    
    void setMass(float _mass)
    {
      mass = _mass;
    }
    
    void setDensity(float _density)
    {
      density = _density;
    }
    
    void setVelocity(float _velocity) 
    {
    velocity = _velocity;
    }
    
    void setPrevVelocity(float _prevVelocity) 
    {
    prevVelocity = _prevVelocity;
    }
  
    //rest density will be updated from the GUI
    void setPressure() 
    {
      pressure = k * (density - restDensity);
    }
  
    void addDensity(float _density) {
      density += _density;
    }


//functions to update the velocity, using acceleration

    //updates the acceleration by x and y
    void accelerate(float xForce, float yForce) 
    {
      dXforce += xForce / density;
      dYforce += yForce / density;
    }
    
    //updates the velocity by x and y
    void updateVelocity(float dt) 
    {
      xForce += dXforce * dt;
      yForce += dYforce * dt;
    
      x += xForce * dt;
      y += yForce * dt;
   
      //initializa the params for the next iteration
      dXforce = 0;
      dYforce = 0;
    
      density = 0;
      pressure = 0;
    }
  
}
