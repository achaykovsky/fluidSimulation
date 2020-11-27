class Fluid
{
  int particlesNumber;
  int h;
  float restDensity;
  float k; 

  Fluid()
  {
    particlesNumber = 10000;
    restDensity = 0.05;
    h = 1;    
    k = 10;
  }


  Fluid(int _particlesNumber, int _h, float _restDensity, float _k)
  {
    particlesNumber = _particlesNumber;
    restDensity = _restDensity;
    h = _h;    
    k = _k;
  }
  
  
   void setParticlesNumber(int _particlesNumber) 
    {
      particlesNumber = _particlesNumber;
    }
    
    void setRestDensity(float _restDensity) 
    {
      restDensity = _restDensity;
    }
    
    void setH(int _h) 
    {
      h = _h;
    }
    
    void setK(float _k) 
    {
      k = _k;
    }
   
   int getParticlesNumber() 
    {
      return particlesNumber;
    }
    
   float getK() 
    {
      return k;
    }
    
    int getH() 
    {
      return h;
    }
    float getRestDensity() 
    {
      return restDensity;
    }







}
