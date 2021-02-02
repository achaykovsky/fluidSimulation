class Fluid
{
  int particlesNumber = 30;
  float h = 1;
  float restDensity;
  float timeStep = 0.5;
  float fluidViscosity = 0.1;
  
  Forces forces = new Forces(h);
  Particle[] particles = new Particle[particlesNumber];
  ParticleSpace grid = new ParticleSpace(600, 800, h);
  
  
  //empty c'tor
  Fluid()
  {
    particlesNumber = 30;
    restDensity = 0.5;
    h = 1;
    for (int i = 0; i < particles.length; i++) 
    {
      float xPos = 600 ,yPos = 180;
      float mass = 0.3;
      Particle initializer = new Particle(xPos + i*random(10), yPos + i*random(10), mass, restDensity);
      particles[i] = initializer; //<>//
    }
  }
  
  //the GUI option
  void updateParticles(int newParticlesNum, float newMass, float newRestDensity)
  {
    for (int i = 0; i < newParticlesNum; i++) 
    {
      float xPos = 600 ,yPos = 180;
      float mass = newMass;
      Particle initializer = new Particle(xPos + i*random(15), yPos + i*random(10), mass, newRestDensity);
      currentFluid.particles[i] = initializer;
    }
  }
  
  
  //setters
   void setParticlesNumber(int _particlesNumber) 
    {
      particlesNumber = _particlesNumber;
      particles = (Particle[]) expand(particles,_particlesNumber);
    }
    
    void setRestDensity(float _restDensity) 
    {
      restDensity = _restDensity;
    }
    
    void setH(float _h) 
    {
      h = _h;
    }
    
    void setTimeStep(float _timeStep)
    {
      timeStep = _timeStep;
    }
    
    void setFluidViscosity(float _fluidViscosity)
    {
      fluidViscosity = _fluidViscosity;
    }
    
   //getters
   int getParticlesNumber() 
    {
      return particlesNumber;
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

    float getFluidViscosity() 
    {
      return fluidViscosity;
    }

  
  void calculatePressure() 
  {
    for (int i = 0; i < particles.length; ++i) 
    {
      int inc = 0;
      //interactions with particles in the same index
      while ((particlesNumber > (i + inc)) && (particles[i].getIndex() == particles[i + inc].getIndex()))
      {
        if ((i + inc) < particlesNumber)
        {
          forces.calculateDensity(particles[i], particles[i + inc]);
          inc++;
        }
      }
      
      //interactions with particles in neighboring index
      if(grid.hasBottomLeft(particles[i].getIndex()))
      {
        inc = 0;
        i = grid.getBottomLeftPosition(particles[i].getIndex());
        while ((particlesNumber > (i + inc)) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
        {
          forces.calculateDensity(particles[i], particles[i + inc]);
          inc++;
        }
      }
      if (grid.hasBottom(particles[i].getIndex())) 
      {
        inc = 0;
        i = grid.getBottomPosition(particles[i].getIndex());
        while ((particlesNumber > (i + inc)) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
        {
          forces.calculateDensity(particles[i], particles[i + inc]);
          inc++;
        }
      }
      if (grid.hasBottomRight(particles[i].getIndex())) 
      {
        inc = 0;
        i = grid.getBottomRightPosition(particles[i].getIndex());
        while ((particlesNumber > (i + inc)) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
        {
          forces.calculateDensity(particles[i], particles[i + inc]);
          inc++;
        }
      }
  
      if (grid.hasRight(particles[i].getIndex())) 
      {
        inc = 0;
        i = grid.getRightPosition(particles[i].getIndex());
        while ((particlesNumber > i + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
        {
          forces.calculateDensity(particles[i], particles[i + inc]);
          inc++;
        }
      }
      //
      //if (grid.hasLeft(particles[i].getIndex())) 
      //{
      //  inc = 0;
      //  i = grid.getLeftPosition(particles[i].getIndex());
      //  println("here");
      //  while ((particlesNumber > i + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
      //  {
      //    forces.calculateDensity(particles[i], particles[i + inc]);
      //    inc++;
      //  }
      //}
      //
      // if (grid.hasTop(particles[i].getIndex())) 
      //{
      //  inc = 0;
      //  i = grid.getTopPosition(particles[i].getIndex());
      //  while ((particlesNumber > i + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
      //  {
      //    forces.calculateDensity(particles[i], particles[i + inc]);
      //    inc++;
      //  }
      //}
      //
      //if (grid.hasTopRight(particles[i].getIndex())) 
      //{
      //  inc = 0;
      //  i = grid.getTopRightPosition(particles[i].getIndex());
      //  while ((particlesNumber > i + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
      //  {
      //    forces.calculateDensity(particles[i], particles[i + inc]);
      //    inc++;
      //  }
      //}
      
      //if (grid.hasTopLeft(particles[i].getIndex())) 
      //{
      //  inc = 0;
      //  i = grid.getTopLeftPosition(particles[i].getIndex());
      //  while ((particlesNumber > i + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
      //  {
      //    forces.calculateDensity(particles[i], particles[i + inc]);
      //    inc++;
      //  }
      //}
      
      
      
      particles[i].setPressure();
    }
  }
  
  void calculateForces() 
  {
    for (int i = 0; i < particles.length; i++) 
    {
      int index = i;
      int inc = 0;
  
      //interactions with particles in the same index
      while ((particlesNumber > index + inc) && (particles[i].getIndex() == particles[i + inc].getIndex())) 
      {
        if (i + inc < particlesNumber) 
        {
          //calculates the forces that work on the two particles
          forces.calculateParticlesPressure(particles[i], particles[i + inc]);
          forces.calculateViscosity(particles[i], particles[i + inc]);
          //forces.calculateSurfaceTension(particles[i], particles[i + inc]);
          //forces.collide(particles[i], particles[i + inc]);
          inc++;
        }
      }
      
      //interactions with particles in the neighboring indices based on their position.
      if (grid.hasBottomLeft(particles[i].getIndex())) 
      {
        inc = 0;
        index = grid.getBottomLeftPosition(particles[i].getIndex());
        while ((particlesNumber > index + inc) && (particles[index].getIndex() == particles[index + inc].getIndex())) 
        {
          forces.calculateParticlesPressure(particles[i], particles[index + inc]);
          forces.calculateViscosity(particles[i], particles[index + inc]);
          //forces.calculateSurfaceTension(particles[i], particles[index + inc]);
          forces.collide(particles[i], particles[i + inc]);
          inc++;
        }
      }
  
      if (grid.hasBottom(particles[i].getIndex())) 
      {
        inc = 0;
        index = grid.getBottomPosition(particles[i].getIndex());
        while ((particlesNumber > index + inc) && (particles[index].getIndex() == particles[index + inc].getIndex())) 
        {
          forces.calculateParticlesPressure(particles[i], particles[index + inc]);
          forces.calculateViscosity(particles[i], particles[index + inc]);
          //forces.calculateSurfaceTension(particles[i], particles[index + inc]);
          //forces.collide(particles[i], particles[i + inc]);
          inc++;
        }
      }
  
      if (grid.hasBottomRight(particles[i].getIndex())) 
      {
        inc = 0;
        index = grid.getBottomRightPosition(particles[i].getIndex());
        while ((particlesNumber > index + inc) && (particles[index].getIndex() == particles[index + inc].getIndex())) 
        {
          forces.calculateParticlesPressure(particles[i], particles[index + inc]);
          forces.calculateViscosity(particles[i], particles[index + inc]);
          //forces.calculateSurfaceTension(particles[i], particles[index + inc]);
          //forces.collide(particles[i], particles[i + inc]);
          inc++;
        }
      }
  
      if (grid.hasRight(particles[i].getIndex())) 
      {
        inc = 0;
        index = grid.getRightPosition(particles[i].getIndex());
        while ((particlesNumber > index + inc) && (particles[index].getIndex() == particles[index + inc].getIndex())) 
        {
          forces.calculateParticlesPressure(particles[i], particles[index + inc]);
          forces.calculateViscosity(particles[i], particles[index + inc]);
          //forces.calculateSurfaceTension(particles[i], particles[index + inc]);
          //forces.collide(particles[i], particles[i + inc]);
          inc++;
        }
      }
      particles[i].accelerate(0, particles[i].getDensity());
    }
  }
  
  
  //update color from the GUI
  void updateColour(color colour) 
  {
    for (int i = 1; i < particles.length; i++) 
    {
      particles[i].colour = colour;
    }
  }
  
  //the function checks if the particles are at the boundary, and the reorders them to be in it
  void boundaries()
  {
    for (int i = 0; i < particles.length; i++) 
    {
      if (particles[i].getXPos() <= 600) 
      {
        particles[i].setX(600.1);
        //particles[i].setXVelocity(particles[i].getXVelocity()*(-1));
      }
      if (particles[i].getXPos() >= 1200) 
      {
        particles[i].setX(1199.9);
        //particles[i].setXVelocity(particles[i].getXVelocity()*(-1));
      }
      if (particles[i].getYPos() <= 180) 
      {
        particles[i].setY(180.1);
        //particles[i].setYVelocity(particles[i].getYVelocity()*(-1));
      }
      if (particles[i].getYPos() >= 680) 
      {
        particles[i].setY(679.9);
        //particles[i].setYVelocity(particles[i].getYVelocity()*(-1));
      }
    }
  }
  
    
  
 
  
}
