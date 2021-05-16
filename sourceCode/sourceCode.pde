    import g4p_controls.*; //<>//
    import java.awt.*;
    GWindow Screen;
 

    //make fluid
    Fluid currentFluid;
    float kernelRadius = 20; 
    
    //basic simulation params
    float timestep = 2;
    int stepsPerFrame = 1;
    
    //defining simulation window size
    int xMin = 600;
    int xMax = 1280;
    int windoWidth = 680; //xMax-xMin
    int yMin = 75;
    int yMax = 750;
    int windoHeight = 675; //yMax-yMin
    
    
    void settings() 
    {
      size(1400, 900);
    }
    
    void setup() 
    {
      createGUI();
      currentFluid = new Fluid(timestep, kernelRadius);
      currentFluid.createInitialState();
    }

    void draw() 
    {
      background(230);
      stroke(0,0,0);
      strokeWeight(3);
      line(xMin, yMax, xMax, yMax);
      line(xMax, yMin, xMax, yMax);
      line(xMin, yMin, xMin, yMax);
      rect(xMin,yMin,windoWidth,windoHeight);
      strokeWeight(1);
      line(550, 0, 550, height);
      line(250, 800, 250, height*(3/4));
    
      setStepsPerFrame(stepsPerFrame);
    
      currentFluid.displayFluid();
    
      guiModifications();
    }
   
   
     void setStepsPerFrame(int _stepsPerFrame)
     {
        for (int i = 0; i < _stepsPerFrame; i++) 
        {
          currentFluid.simulationStep();
        }
     }



  void guiModifications()
  {
    lblHeader.setFont(new Font("Arial", Font.PLAIN, 30));
    lblHeader.setLocalColorScheme(0);
    lblParticleOptions.setFont(new Font("Arial", Font.PLAIN, 20));
    lblParticleOptions.setLocalColorScheme(2);
    lblFluidOptions.setFont(new Font("Arial", Font.PLAIN, 20));
    lblFluidOptions.setLocalColorScheme(2);
    //lblMass.setFont(new Font("Arial", Font.PLAIN, 15)); 
    lblFluidViscosity.setFont(new Font("Arial", Font.PLAIN, 15)); 
    lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
    lblH.setFont(new Font("Arial", Font.PLAIN, 15));
    lblCurrParticlesNum.setText("Number Of Particles: " + currentFluid.particles.size());
    lblCurrParticlesNum.setFont(new Font("Arial", Font.PLAIN, 15));
    lblSimulation.setFont(new Font("Arial", Font.PLAIN, 20));
    lblSimulation.setLocalColorScheme(0);
    lblCurrent.setFont(new Font("Arial", Font.PLAIN, 18));
    lblCurrent.setLocalColorScheme(0);
    //lblCurrMass.setText("Mass: " + String.format("%.2f",currentFluid.particles[0].getMass()));
    //lblCurrMass.setFont(new Font("Arial", Font.PLAIN, 15));
    lblcurrH.setText("h: " + String.format("%.2f",currentFluid.getH()));
    lblcurrH.setFont(new Font("Arial", Font.PLAIN, 15));
    lblCurrRestDensity.setText("Rest Density: " + String.format("%.2f",currentFluid.getRestDensity()));
    lblCurrRestDensity.setFont(new Font("Arial", Font.PLAIN, 15));
    //lblCurrMyu.setText("µ: " + String.format("%.2f",currentFluid.getFluidViscosity()));
    //lblCurrMyu.setFont(new Font("Arial", Font.PLAIN, 15));
    lblCurrTimeStep.setText("Time Step: " + String.format("%.2f",currentFluid.getTimeStep()));
    lblCurrTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
    lblTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
    lblParticleNum.setFont(new Font("Arial", Font.PLAIN, 15));
  }
