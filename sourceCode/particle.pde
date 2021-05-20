class Particle
{
    float r;
    PVector position;
    PVector previousPosition = new PVector();
    PVector velocity = new PVector (0,9.8);

    float pressure = 0;
    float pressureNear = 0;
    
    float density = 0;
    float densityNear = 0;
    float restDensity;
    
    ArrayList<Particle> neighbors = new ArrayList<Particle>();
    boolean rigid;
    PVector dx = new PVector(0, 0);

  
    //c'tor for the update from GUI option
    Particle(float _xPos, float _yPos, boolean _rigid)
    {
      position = new PVector(_xPos, _yPos);
      velocity = new PVector(0,0);
      rigid = _rigid;
    }
  
    //empty c'tor
    Particle()
    {
      this.velocity.set(0,0);
      this.density = 0;
      this.densityNear = 0;
      this.dx = new PVector(0, 0);
    }
    
    void findNeighbors(ArrayList<Particle> particles, float h) 
    {
     neighbors.clear();
     for (int i = 0; i < particles.size(); i++) 
     {
       Particle p2 = particles.get(i);
       if ((abs(position.x - p2.getPos().x) < h) && (abs(position.y - p2.getPos().y) < h)) 
          neighbors.add(p2);
      }
    }
  
  
    void displayParticle() 
    {
        strokeWeight(10);
        if (isRigid()) 
            stroke(1);
        else 
            stroke(10, 200, 255 - pressure * 1500);
        point(position.x, position.y);
    }
    

    //getters
    PVector getPos()
    {
      return position;
    }
    

    float getDensity()
    {
      return density;
    }
    
    float getDensityNear()
    {
      return densityNear;
    }
    
    float getPressure()
    {
      return pressure;
    }
    
    float getPressureNear()
    {
      return pressureNear;
    }
    
    PVector getVelocity() 
    {
      return velocity;
    }
    
    PVector getdx()
    {
      return dx;
    }
    
    boolean isRigid() 
    {
      return rigid;
    }

    
    
    
    //setters
    void setPos(PVector _pos) 
    {
      position.x = _pos.x;
      position.y = _pos.y;
    }
    
    void addPos(PVector _pos) 
    {
      position.x += _pos.x;
      position.y += _pos.y;
    }
    
    void setPrevPos(PVector _previousPosition) 
    {
      previousPosition.x = _previousPosition.x;
      previousPosition.y = _previousPosition.y;
    }
    
    void setDensity(float _density)
    {
      density = _density;
    }
    
    void setDensityNear(float _densityNear)
    {
      densityNear = _densityNear;
    }
    
    void setXVelocity(float _xVelocity) 
    {
      velocity.x = _xVelocity;
    }
    
    void setYVelocity(float _yVelocity) 
    {
      velocity.y = _yVelocity;
    }
    
    void setVelocity(PVector _velocity) 
    {
      velocity.x = _velocity.x;
      velocity.y = _velocity.y;
    }
    
    void setdx(PVector _dx) 
    {
      dx.x = _dx.x;
      dx.y = _dx.y;
    }
    
    void setRigid(boolean _rigid) 
    {
      rigid = _rigid;
    }
    
  
    //rest density will be updated from the GUI
    // compute pressure: formula (2)
    void setPressure() 
    {
      pressure = currentFluid.k * (density - restDensity);
    }
    
    //compute near-pressure: formula (5)
    void setNearPressure() 
    {
      pressureNear = currentFluid.kNear * densityNear;
    }
  
    void addDensity(float _density) 
    {
      this.density += _density;
    }
    
   
   //functions to update the velocity of the particle
    void updateVelocity(Particle particle)
    {
        particle.setVelocity(PVector.sub(particle.getPos(), particle.previousPosition));
        particle.setVelocity(PVector.div(particle.getVelocity(),currentFluid.timeStep));
    }
    
}
