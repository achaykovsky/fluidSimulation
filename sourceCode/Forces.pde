class Forces
{
  // compute density and near-density: formula (1) and (4)
  void calculateDensity(Particle particle) 
  {
        for (Particle particleNeighbor : particle.neighbors) 
        {
          if ((particleNeighbor != particle)) 
          {
            PVector distanceVec = PVector.sub(particleNeighbor.getPos(), particle.getPos());
            float distance = distanceVec.mag(); //calculating the distance xj-xi
            float q = distance / currentFluid.h;
            if (q < 1) 
            {
              //rho += (1-q)^2
              float z = 1-q;
              particle.setDensity(particle.getDensity() + pow(z,2));
              //rho near += (1-q)^3
              particle.setDensityNear(particle.getDensityNear() + pow(z,3));
            }
          }
        }
  }
  
  //Algorithm 2: Double Density Relexation
  void calculateParticlesPressure(ArrayList<Particle> particles) 
  {
    for (Particle particle : particles) 
    {
      particle.findNeighbors(particles, currentFluid.h); 
      particle.setDensity(0);
      particle.setDensityNear(0);
      
      calculateDensity(particle);

      particle.setPressure();

      particle.setNearPressure();

      particle.setdx(new PVector(0,0));
      for (Particle particleNeighbor : particle.neighbors) 
      {
        PVector distanceVec = PVector.sub(particleNeighbor.getPos(), particle.getPos());
        float distance = distanceVec.mag(); //calculating the distance xj-xi
        float q = distance / currentFluid.h;
        if (q < 1) 
        {
          distanceVec.normalize();
          PVector D = distanceVec;
          D.mult(pow(currentFluid.timeStep,2) * (particle.getPressure() * (1-q) + particle.getPressureNear() * pow((1-q),2)));
          //note: here in the original formula in the article, D supposed to be divided by 2.
          // I discovered that removing it makes it look better (at least in my version, in processing).
          if (particleNeighbor.isRigid() != true) 
            particleNeighbor.addPos(D);
          particle.setdx(PVector.sub(particle.getdx(),D));
        }
      } 
      if (particle.isRigid() != true) 
        particle.addPos(particle.getdx());
    }
  }
  
  // Algorithm 5: calculate the viscosity
  void calculateViscosity(ArrayList<Particle> particles) 
  {
    for (Particle particle : particles) 
    {
      particle.findNeighbors(particles,currentFluid.h); 
      for (Particle particleNeighbor : particle.neighbors) 
      {
        PVector distanceVec = PVector.sub(particleNeighbor.getPos(), particle.getPos());
        float distance = distanceVec.mag();//calculating the distance xj-xi
        float q = distance / currentFluid.h;
        if (q < 1) 
        {
          distanceVec.normalize();
          PVector D = distanceVec;
          PVector velocitySub = PVector.sub(particleNeighbor.getVelocity(), particle.getVelocity());
          float u = D.dot(velocitySub);
          if (u > 0)
          {
            float impulse = currentFluid.timeStep * (1-q) * ((u * currentFluid.getSigma()) + (pow(u,2)) * (currentFluid.getBeta()));
            particleNeighbor.setXVelocity(particleNeighbor.getVelocity().x - impulse / 2);
            particleNeighbor.setYVelocity(particleNeighbor.getVelocity().y - impulse / 2);
            particle.setXVelocity(particle.getVelocity().x + impulse / 2);
            particle.setYVelocity(particle.getVelocity().y + impulse / 2);
          }
        }
      } 
    }
  }
  
  
  void updateVelocity(ArrayList<Particle> particles)
  {
   for (Particle particle : particles) 
        particle.updateVelocity(particle);
  }
  
  
  void updatePredictedPosition(ArrayList<Particle> particles)
  {
    for (Particle particle : particles) 
    {
       // save previous position
       particle.setPrevPos(particle.getPos().copy());
       // advance to predicted position
       particle.addPos(PVector.mult(particle.getVelocity(), currentFluid.getTimeStep()));
     }
  }

  void calculateGravityForce(ArrayList<Particle> particles)
  {
    for (Particle particle : particles) 
    {
      if (particle.isRigid() != true) 
        particle.getVelocity().add(currentFluid.getGravity());
    }
  }
  
}
