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
  
  void calculateDensity(Particle p1, Particle p2) 
  {
    float rSquared = pow(dist(p1.getPos().x,p1.getPos().y,p2.getPos().x,p2.getPos().y),2);//r^2
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
    float r = dist(p1.getPos().x,p1.getPos().y,p2.getPos().x,p2.getPos().y);
    float rSquared = pow(r,2);
    if (hSquared > rSquared) 
    {
        PVector viscosityForce = new PVector(0,0);
        viscosityForce.x = currentFluid.getFluidViscosity() * p2.getMass() * ((p2.getVelocity().x - p1.getVelocity().x) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        viscosityForce.y = currentFluid.getFluidViscosity() * p2.getMass() * ((p2.getVelocity().y - p1.getVelocity().y) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        p1.accelerate(viscosityForce.x, viscosityForce.y);
        viscosityForce.x = currentFluid.getFluidViscosity() * p1.getMass() * ((p1.getVelocity().x - p2.getVelocity().x) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        viscosityForce.y = currentFluid.getFluidViscosity() * p1.getMass() * ((p1.getVelocity().y - p2.getVelocity().y) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        p2.accelerate(viscosityForce.x, viscosityForce.y);
    }
  }

  void calculateParticlesPressure(Particle p1, Particle p2) 
  {
    float r = dist(p1.getPos().x,p1.getPos().y,p2.getPos().x,p2.getPos().y);
    float rSquared = pow(r,2);
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    if ((hSquared > rSquared) && (r != 0)) 
    {
      float pressureForce = (p2.getMass()*(p1.getPressure() + p2.getPressure()) / (2 * p2.getDensity())) * spikyConst * pow((h - r), 3);
      PVector pressureVecForce = new PVector(pressureForce * (distance.x / r),pressureForce * (distance.y / r));
      p1.accelerate(pressureVecForce.x, pressureVecForce.y);
      pressureForce = (p1.getMass()*(p2.getPressure() + p1.getPressure()) / (2 * p1.getDensity())) * spikyConst * pow((h - r), 3);
      pressureVecForce.set((-1) * pressureForce * (distance.x / r),(-1) * pressureForce * (distance.y / r));
      p2.accelerate(pressureVecForce.x, pressureVecForce.y);
    }
  }

  void calculateSurfaceTension(Particle p1, Particle p2) 
  {
    float r = dist(p1.getPos().x,p1.getPos().y,p2.getPos().x,p2.getPos().y);
    float rSquared = pow(r,2);
    PVector distance = new PVector(p1.getPos().x - p2.getPos().x,p1.getPos().y - p2.getPos().y);
    if ((hSquared > rSquared) && (r!= 0)) 
    {
      float n = (p1.getMass()/p1.getDensity()) * poly6Const * pow((hSquared - rSquared), 3);
      float surfaceForce = (p1.getMass() / p1.getDensity()) * poly6GradConst * (5*(pow(rSquared - hSquared,2))* (n / abs(n)));//?
      PVector surfaceVecForce = new PVector(surfaceForce * (distance.x / r), surfaceForce * (distance.y / r));
      p1.accelerate(surfaceVecForce.x, surfaceVecForce.y);
      n = (p2.getMass() / p2.getDensity()) * poly6Const * pow((hSquared - rSquared), 3);
      surfaceForce = currentFluid.getTimeStep()*(p2.getMass() / p2.getDensity()) * poly6GradConst * (rSquared - hSquared)* (n / abs(n));
      surfaceVecForce.set((-1) * surfaceForce * (distance.x / r), (-1) * surfaceForce * (distance.y / r));
      p2.accelerate(surfaceVecForce.x, surfaceVecForce.y);
    }
  }  
  
}
