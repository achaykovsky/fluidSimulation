class Fluid //<>//
{
  float h;
  float restDensity = 10;
  float k = 0.008;
  float kNear = 0.01;
  PVector gravity = new PVector(0, 0.01);;
  float timeStep;
  float sigma = 0.1;
  float beta = 0.003;

  Forces forces = new Forces();
  ParticleSpace grid = new ParticleSpace(windoWidth, windowHeight, h);
  ArrayList<Particle> particles;
  
  //empty c'tor
  Fluid()
  {
    particles = new ArrayList<Particle>();
    gravity.mult(timeStep);
    grid = new ParticleSpace(windoWidth, windowHeight, h); //(680, 675, h)
  }
  
    Fluid(float timeStep, float h) 
  {
    particles = new ArrayList<Particle>();
    gravity.mult(timeStep);
    this.timeStep = timeStep;
    this.h = h;
    grid = new ParticleSpace(windoWidth, windowHeight, h);//(680, 675, h)
  }
  
  //the GUI option
  void updateParticles(float _restDensity)
  {
    particles = new ArrayList<Particle>();
    gravity.mult(timeStep);
    restDensity = _restDensity;
    grid = new ParticleSpace(windoWidth, windowHeight, h);//(680, 675, h)
  }
  
  
  //setters
    void setRestDensity(float _restDensity) 
    {
      this.restDensity = _restDensity;
    }
    
    void setH(float _h) 
    {
      this.h = _h;
    }
    
    void setTimeStep(float _timeStep)
    {
      this.timeStep = _timeStep;
    }
    
    void setBeta(float _beta)
    {
      this.beta = _beta;
    }
   
    void setSigma(float _sigma)
    {
      this.sigma = _sigma;
    }
    
   //getters
   int getParticlesNumber() 
    {
      return particles.size();
    }
    
    float getTimeStep() 
    {
      return timeStep;
    }
    
    float getH() 
    {
      return h;
    }
    
    float getRestDensity() 
    {
      return restDensity;
    }
    
    float getBeta() 
    {
      return beta;
    }
    
    float getSigma() 
    {
      return sigma;
    }

    //creating the initial state of the water
    void createInitialState() 
    {
      constructFloor();
      constructRightWall();
      constructLeftWall();
    }
    
    void constructRightWall()
    {
      for (float y = yMin; y < yMax; y += kernelRadius * 0.1) 
      {
        currentFluid.particles.add(new Particle(xMax, y, false));
      }
    }
    
    void constructLeftWall()
    {
      for (float y = yMin; y < yMax; y += kernelRadius * 0.1) 
      {
        currentFluid.particles.add(new Particle(xMin, y, false));
      }
    }
    
    void constructFloor()
    {
      for (float x = xMin; x < xMax; x += kernelRadius * 0.1) 
      {
        //creating the horizontal "floor"
        currentFluid.particles.add(new Particle(x, yMax, false));
      }
    }
    
    void constructCeiling()
    {
      for (float x = xMin; x < xMax; x += kernelRadius * 0.1) 
      {
        //creating the horizontal "ceiling"
        currentFluid.particles.add(new Particle(x, yMin, false));
      }
    }
    

    
    //showing all the particles
    void displayFluid() 
    {
      for (Particle particle : particles) 
        particle.displayParticle();
    }
    
    void simulationStep() 
    {
      forces.calculateGravityForce(particles);
      forces.calculateViscosity(particles);
      forces.updatePredictedPosition(particles);
      
      // double density relaxation
      // prepare search for neighbors:
      for (Particle particle : particles) 
        grid.addParticle(particle);
      
      forces.calculateParticlesPressure(particles);
      boundaries(particles);
      forces.updateVelocity(particles, this.timeStep);
    }
  
  
  //the function checks if the particles are at the boundary, and the reorders them to be in it
  void boundaries(ArrayList<Particle> particles)
  {
    
    for (Particle particle : particles) 
    {
      if (particle.getPos().x < xMin)
      {
        particle.position.x = xMin + 0.5;
        particle.setXVelocity(particle.getVelocity().x * -1);
      }
      if (particle.getPos().x > xMax)
      {
        particle.position.x = xMax - 0.1;
        particle.setXVelocity(particle.getVelocity().x * -1);
      }
      if (particle.getPos().y < yMin) 
      {
        particle.position.y = yMin + 0.5;
        particle.setYVelocity(particle.getVelocity().y * -1);
      }
      if (particle.getPos().y > yMax)
      {
        particle.position.y = yMax - 0.1;
        particle.setYVelocity(particle.getVelocity().y * -1);
      }
    }
  }
  
  
}
