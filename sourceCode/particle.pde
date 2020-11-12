class Particle
{
    //r=(xPos,yPos) - location of the particle:
    float xPos;
    float yPos;
    
    float mass;
    float density;
    float viscosity;
    float k; //fluid constant
    float pressure;
    color colour;
  
  
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
}