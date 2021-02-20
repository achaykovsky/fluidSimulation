class ParticleSpace
{
    int gridX, gridY;
    int[] hashTable;
    int gridSize;
    float size;
  
  ParticleSpace(float XLength, float YHeight, float h)
  {
    gridX = floor(XLength / h);
    gridY = floor(YHeight / h);
    gridSize = gridX * gridY;
    size = h;
  
    int[] _hashTable = new int[gridSize];
    hashTable = _hashTable;
    
  }

  //setting the indices for each particle
  void particlesMatrix(Particle[] particles) 
  {
    for (int i = 0; i < particles.length; i++) 
      particles[i].setIndex(((floor(particles[i].getPos().x/size)) + (floor(particles[i].getPos().y/size)))); //<>//
  }

  //finding the maximal index in the hash
  int getMaxIndex(Particle[] particles) 
  {
    int maxIndx;
    int[] indices = new int[particles.length];
    for (int i = 0; i < particles.length; i++)
    {
        indices[i] = particles[i].getIndex();
        //println("indices[i] " + i + " "+ indices[i]);
    }
    maxIndx = max(indices);
    //println("maxIndx " + maxIndx);
    return maxIndx;
  }

  //counting sort algorithm
  void countingSort(Particle[] particles, int exp) 
  {
    int size = particles.length;
    int[] count = new int[size];
    Particle[] countedParticles = new Particle[size];
 
    for (int i = 1; i < count.length; i++) 
      count[i] = 0;
  
    for (int i = 0; i < particles.length; i++)
      count[(particles[i].getIndex() / exp) % 10]++;
  
    for (int i = 1; i < count.length ; i++)
      count[i] += count[i - 1];
  
    for (int i = particles.length - 1; i >= 0; i--)
    {
      countedParticles[count[(particles[i].getIndex() / exp) % 10] - 1] = particles[i];
      count[(particles[i].getIndex() / exp) % 10]--;
    }
  
    for (int i = 0; i < particles.length; i++) 
      particles[i] = countedParticles[i];
  }
  
  //sorting the particles
  void sortParticles(Particle[] particles)
  {
    int maxIndex = getMaxIndex(particles);
    for (int exp = 1; maxIndex / exp > 0; exp *= 10)
      countingSort(particles, exp);
  }

  void initialize(Particle[] particles) 
  {
    int lastIndex = 0;
    boolean firstIndex = false;
    for (int i = 0; i < particles.length; i++) 
    {
     if (particles[i].getIndex() == 0 && firstIndex == false) 
          {
          hashTable[0] = 0;
          firstIndex = true;
          }
     else 
         {
           hashTable[0] = EMPTY;
         }
      if (particles[i].getIndex() > lastIndex) 
      {
        for (int index = lastIndex; index < particles[i].getIndex(); index++)
          hashTable[index] = EMPTY;
        hashTable[particles[i].getIndex()] = i;
        lastIndex = particles[i].getIndex();
      }
      if ((i == (particles.length - 1)) && (particles[i].getIndex() < (gridSize - 1))) 
      {
        for (int index = lastIndex; index < gridSize; index++) 
          hashTable[index] = EMPTY;
      }
    }
  }

  //int getCenterPosition(int index) 
  //{
  //  return hashTable[index];
  //}

  //int getTopLeftPosition(int index) 
  //{
  //  return hashTable[index - gridY - 1];
  //}

  //int getTopPosition(int index) 
  //{
  //  return hashTable[index - gridY];
  //}

  //int getTopRightPosition(int index) 
  //{
  //  return hashTable[index - gridX + 1];
  //}
  
  int getRightPosition(int index) 
  {
    return hashTable[index + 1];
  }
  
  int getBottomRightPosition(int index) 
  {
    return hashTable[index + gridX + 1];
  }
  
  int getBottomPosition(int index) 
  {
    return hashTable[index + gridX];
  }
  
  int getBottomLeftPosition(int index) 
  {
    return hashTable[index + gridX - 1];
  }
  
  //int getLeftPosition(int index) 
  //{
  //  return hashTable[index - 1];
  //}
  
  
  //boolean hasTopLeft(int index) 
  //{
  //  if ((index % gridX != 0) && (index >= gridX)) 
  //  {
  //    if (hashTable[index - gridX - 1] != EMPTY) 
  //      return true;
  //  }
  //  return false;
  //}

  //boolean hasTop(int index) 
  //{
  //  if (index >= gridX) 
  //  {
  //    if (hashTable[index - gridX] != EMPTY) 
  //      return true;
  //  }
  //  return false;
  //}
  
  //boolean hasTopRight(int index) 
  //{
  //  if ((index % gridX != gridX - 1) && (index >= gridX)) 
  //  {
  //    if (hashTable[index - gridX + 1] != EMPTY) 
  //      return true;
  //  }
  //  return false;
  //}

  boolean hasRight(int index) 
  {
    if (index % gridX != gridX - 1) 
    {
      if (hashTable[index + 1] != EMPTY) 
        return true;
    }
    return false;
  }
  
  boolean hasBottomRight(int index) 
  {
    if ((index % gridX != gridX - 1) && (index < gridSize - gridX)) 
    {
      if (hashTable[index + gridX + 1] != EMPTY) 
        return true;
    }
    return false;
  }
 
  
  boolean hasBottom(int index) 
  {
    if (index < (gridSize - gridX)) 
    {
      if (hashTable[index + gridX] != EMPTY) 
        return true;
    }
    return false;
  }

  boolean hasBottomLeft(int index) 
  {
    if ((index % gridX != 0) && (index < gridSize - gridX))
    {
      if (hashTable[index + gridX - 1] != EMPTY) 
        return true;
    }
    return false;
  }
  
  boolean hasLeft(int index) 
  {
    if (index % gridX != 0) 
    {
      if (hashTable[index - 1] != EMPTY) 
        return true;
    }
    return false;
  }

}
