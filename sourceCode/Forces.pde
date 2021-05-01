class Forces
{
    float h = 1;//h smoothing kernel radius
    float hSquared = 1;
    float spikyConst = 0;
    float poly6Const = 0;
    float poly6GradConst = 0;
    float viscosityGradConstSquared = 0;

  Forces(float _h)
  {
    this.h = _h;
    this.hSquared = pow(h, 2);
    this.spikyConst = 15.0 / (PI*pow(h, 6));
    this.poly6Const = 315.0 / (64*PI*pow(h, 9));
    this.poly6GradConst = -945.0 / (32 * PI*pow(h, 9));
    this.viscosityGradConstSquared = 45.0 / (PI * pow(h, 6));
  }
  
  void calculateDensity(Particle p1, Particle p2) //checked
  {
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    float rSquared = pow(distance.x,2) + pow(distance.y,2);
    //p1.setDensity(315.0 / (64.0 * PI * pow(h, 3)));
    //p2.setDensity(315.0 / (64.0 * PI * pow(h, 3)));
    if (hSquared > rSquared) 
    {
      float density = (p1.getMass()) * poly6Const * pow((hSquared - rSquared), 3);//poly6*(h^2-r^2)^3
      if (density != 0)
      {
        p1.addDensity(density);
        p2.addDensity(density);
      }
    }
  }


  void calculateViscosity(Particle p1, Particle p2) 
  {
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    float rSquared = pow(distance.x,2) + pow(distance.y,2);
    float r = sqrt(rSquared);
    if (hSquared > rSquared) 
    {
        PVector viscosityForce = new PVector(0,0);
        viscosityForce.x = currentFluid.getFluidViscosity() * p2.getMass() * ((p2.getVelocity().x - p1.getVelocity().x) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        viscosityForce.y = currentFluid.getFluidViscosity() * p2.getMass() * ((p2.getVelocity().y - p1.getVelocity().y) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        p1.viscosity.set(viscosityForce.x,viscosityForce.y);
        p1.accelerate(viscosityForce.x, viscosityForce.y);
        viscosityForce.x = currentFluid.getFluidViscosity() * p1.getMass() * ((p1.getVelocity().x - p2.getVelocity().x) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        viscosityForce.y = currentFluid.getFluidViscosity() * p1.getMass() * ((p1.getVelocity().y - p2.getVelocity().y) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        p2.viscosity.set(viscosityForce.x,viscosityForce.y);
        p2.accelerate(viscosityForce.x, viscosityForce.y);
    }
  }

  void calculateParticlesPressure(Particle p1, Particle p2) 
  {
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    float rSquared = pow(distance.x,2) + pow(distance.y,2);
    float r = sqrt(rSquared);
    if ((hSquared > rSquared) && (rSquared != 0))  
    {
      float pressureForce = (p2.getMass()*(p1.getPressure() + p2.getPressure()) / (2 * p2.getDensity())) * spikyConst * pow((h - r), 3);
      PVector pressureVecForce = new PVector(pressureForce * (distance.x / rSquared),pressureForce * (distance.y / rSquared));
      p1.pressureForce.set(pressureVecForce.x,pressureVecForce.y);
      p1.accelerate(pressureVecForce.x, pressureVecForce.y);
      pressureForce = (p1.getMass()*(p2.getPressure() + p1.getPressure()) / (2 * p1.getDensity())) * spikyConst * pow((h - r), 3);
      pressureVecForce.set((-1) * pressureForce * (distance.x / rSquared),(-1) * pressureForce * (distance.y / rSquared));
      p2.pressureForce.set(pressureVecForce.x,pressureVecForce.y);
      p2.accelerate(pressureVecForce.x, pressureVecForce.y);
    }
  }

  void calculateSurfaceTension(Particle p1, Particle p2) 
  {
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    float rSquared = pow(distance.x,2) + pow(distance.y,2);
    //float r = sqrt(rSquared);
    if ((hSquared > rSquared) && (rSquared!= 0))  
    {
      float n = (p1.getMass()/p1.getDensity()) * poly6Const * pow((hSquared - rSquared), 3);
      float surfaceForce = currentFluid.getTimeStep()*(p1.getMass() / p1.getDensity()) * poly6GradConst * (rSquared - hSquared)*(5*rSquared - hSquared) * (n / abs(n));//?
      PVector surfaceVecForce = new PVector((-1) * surfaceForce * (distance.x / rSquared), (-1) * surfaceForce * (distance.y / rSquared));
      p1.surfaceTension.set(surfaceVecForce.x,surfaceVecForce.y);
      p1.accelerate(surfaceVecForce.x, surfaceVecForce.y);
      n = (p2.getMass() / p2.getDensity()) * poly6Const * pow((hSquared - rSquared), 3);
      surfaceForce = currentFluid.getTimeStep()*(p2.getMass() / p2.getDensity()) * poly6GradConst * (rSquared - hSquared)*(5*rSquared - hSquared) * (n / abs(n));
      surfaceVecForce.set((-1) * surfaceForce * (distance.x / rSquared), (-1) * surfaceForce * (distance.y / rSquared));
      p2.surfaceTension.set(surfaceVecForce.x,surfaceVecForce.y);
      p2.accelerate(surfaceVecForce.x, surfaceVecForce.y);
    }
  } 
  
  void calculateGravityForce(Particle p)
  {
     float xGravity = p.gravAcceleration.x * p.getDensity();
     float yGravity = p.gravAcceleration.y * p.getDensity();
     p.gravity.set(xGravity,yGravity);
     p.accelerate(xGravity, yGravity);
  }
  
}
  
  
  
