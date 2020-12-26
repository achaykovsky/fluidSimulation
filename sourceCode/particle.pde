class Particle
{
    int index = 0;
    float r;
    float xPos;
    float yPos;
    float prevVelocity = 0;
    float velocity;
    float mass;
    float density;
    //float viscosity;
    float pressure;
    color colour;
    float restDensity;
    float dXforce = 0;
    float dYforce = 0;
    float xForce = 0;
    float yForce = 0;
    float x;
    float y;
    float dt;
  
  
  Particle(float _xPos, float _yPos, float _mass, float _restDensity)
  {
    this.xPos = _xPos;
    this.yPos = _yPos;
    this.colour = color(30,193,250);
    this.mass = _mass;
    this.restDensity = _restDensity;
    //this.viscosity = _viscosity;
    this.density = 0;
    this.pressure = 0;
    //this.velocity = _velocity;
    //this.prevVelocity = _prevVelocity;
  }

  //empty c'tor
  Particle()
  {
    this.xPos = 0;
    this.yPos = 0;
    this.mass = 0;
    //this.viscosity = 0;
    this.density = 0;
    this.pressure = 0;
    this.density = 0;
  }
  
  Particle(Particle particle) 
  {
    this.xPos = particle.xPos;
    this.yPos = particle.yPos;
    this.colour = particle.colour;
    this.mass = particle.mass;
    this.restDensity = particle.restDensity;
    //this.viscosity = particle.viscosity;
    //this.velocity = particle.velocity;
    //this.prevVelocity = particle.prevVelocity;
    }
  
    void drawCircle(float xPos, float yPos, float h)
    {
      pushMatrix();
      fill(30,193,250);
      circle(xPos, yPos, h*10);
      noStroke(); 
      fill(30,193,250);
      popMatrix();
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
    
    //float getViscosity()
    //{
    //  return viscosity;
    //}
    
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
  
    void addDensity(float _density) 
    {
      density += _density;
    }
    
    void setIndex(int _index) 
    {
      index = _index;
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
