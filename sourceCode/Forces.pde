class Forces
{
    float h = 0;//h smoothing kernel radius
    float hSquared = 0;
    float spikyConst = 0;
    float poly6Const = 0;
    float viscosityConst = 0;
    float viscosityGradConstSquared = 0;

  Forces(float _h)
  {
    this.h = _h;
    this.hSquared = pow(h, 2);
    this.spikyConst = 15.0 / (PI*pow(h, 6));
    this.poly6Const = 315.0 / (64*PI*pow(h, 9));
    this.viscosityConst = 15.0 / (TWO_PI * pow(h, 3));
    this.viscosityGradConstSquared = 45.0 / (PI * pow(h, 6));
  }
  
  void density(Particle p1, Particle p2) 
  {
    float rSquared = pow(dist(p1.getXPos(),p1.getYPos(),p2.getXPos(),p2.getYPos()),2);//h^2
    if (hSquared > rSquared) 
    {
      float density = (p1.getMass()) * poly6Const * pow((hSquared - rSquared), 3);//poly6*(h^2-r^2)^3
      p1.addDensity(density);
      p2.addDensity(density);
    }
  }

  void viscosity(Particle p1, Particle p2) 
  {
    float r = dist(p1.getXPos(),p1.getYPos(),p2.getXPos(),p2.getYPos());
    float rSquared = pow(r,2);
    if (hSquared > rSquared) 
    {
        float viscosityXForce = p2.getMass() * ((p2.getVelocity() - p1.getVelocity()) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        float viscosityYForce = p2.getMass() * ((p2.getPrevVelocity() - p1.getPrevVelocity()) / p2.getDensity()) * viscosityGradConstSquared * (h - r);
        p1.accelerate(viscosityXForce, viscosityYForce);
        viscosityXForce = p1.getMass() * ((p1.getVelocity() - p2.getVelocity()) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        viscosityYForce = p1.getMass() * ((p1.getPrevVelocity() - p2.getPrevVelocity()) / p1.getDensity()) * viscosityGradConstSquared * (h - r);
        p2.accelerate(viscosityXForce, viscosityYForce);
    }
  }

  void pressure(Particle p1, Particle p2) 
  {
    float r = dist(p1.getXPos(),p1.getYPos(),p2.getXPos(),p2.getYPos());
    float rSquared = pow(r,2);
    float xDist = p1.getXPos() - p2.getXPos();
    float yDist = p1.getYPos() - p2.getYPos();
    if (hSquared > rSquared) 
    {
      float pressureForce = (p2.getMass()*(p1.getPressure() + p2.getPressure()) / (2 * p2.getDensity())) * spikyConst * pow((h - r), 3);
      float pressureXForce = pressureForce * (xDist / r);
      float pressureYForce = pressureForce * (yDist / r);
      p1.accelerate(pressureXForce, pressureYForce);
      pressureForce = (p1.getMass()*(p2.getPressure() + p1.getPressure()) / (2 * p1.getDensity())) * spikyConst * pow((h - r), 3);
      pressureXForce = -pressureForce * (xDist / r);
      pressureYForce = -pressureForce * (yDist / r);
      p2.accelerate(pressureXForce, pressureYForce);
    }
  }

  
  
}
