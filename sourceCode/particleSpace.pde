class ParticleSpace //<>//
{
    int gridX, gridY;
    Hash[] hashTable;
    int gridSize;
    float size;
  
    ParticleSpace(float XLength, float YHeight, float h)
    {
      gridX = int(XLength / h);
      gridY = int(YHeight / h);
      gridSize = gridX * gridY;
      size = h;
    
      hashTable = new Hash[gridSize];
  
      for (int i = 0; i < hashTable.length; i++) 
      {
        hashTable[i] = new Hash();
      }
    }
  
    Hash getHash(float x, float y) 
    {
      int hashWidth = int(x / size);
      int hashHeight = int(y / size);
        if ((hashWidth >= 0) && (hashWidth < gridX) && (hashHeight >= 0) && (hashHeight < gridY)) 
        {
          int index = hashWidth * gridY + hashHeight;
            return hashTable[index];
        }
      return null;
    }
  
    
    void addParticle(Particle particle) 
    {
      for ( int i = 0; i < 2; i++ )
      {
        for ( int j = 0; j < 2; j++)
        {
          float x = particle.getPos().x + size * int(i);
          float y = particle.getPos().y + size * int(j);
          Hash H = getHash(x, y);
          if (H != null) 
          {
            H.particles.add(particle);
          }
        }
      }
    }
  
}
  


class Hash 
{
  ArrayList<Particle> particles;
  Hash() 
  {
    particles = new ArrayList<Particle>();
  }
}
