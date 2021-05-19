    import g4p_controls.*; //<>//
    import java.awt.*;
    GWindow Screen;
 

    //make fluid
    Fluid currentFluid;
    float kernelRadius = 10; 
    
    //basic simulation params
    int timeStep = 2;
    int stepsPerFrame = 1;
    int mousePressedTimes = 5;
    
    //defining simulation window size
    int xMin = 600;
    int xMax = 1280;
    int windoWidth = 680; //xMax-xMin
    int yMin = 75;
    int yMax = 750;
    int windowHeight = 675; //yMax-yMin
    
    //creating the class with general basic properties
    GeneralProperties currentSimulation = new GeneralProperties();
    
    
    void settings() 
    {
      size(1400, 900);
    }
    
    void setup() 
    {
      createGUI();
      currentFluid = new Fluid(timeStep, kernelRadius);
      //GeneralProperties currentSimulation = new GeneralProperties();
      currentFluid.createInitialState();
      currentSimulation.setMousePressedTimes(mousePressedTimes);
      currentSimulation.setStepsPerFrame(stepsPerFrame);
     // currentSimulation.initializeParams();
    }

    void draw() 
    {
      background(230);
      stroke(0,0,0);
      strokeWeight(3);
      rect(xMin,yMin,windoWidth,windowHeight);
      //fill(0,200,250);
      fill(#71E4FF);
      strokeWeight(1);
      line(550, 0, 550, height);//the main vertical seperator
      line(250, 150, 250, 800);//the vertical seperator between the sliders
      line(0, 450, 550, 450);//the horizontal seperator
      
      
      currentSimulation.setMousePressedTimes(mousePressedTimes);

      currentSimulation.setStepsPerFrame(stepsPerFrame);
      
      currentSimulation.guiModifications();
      
      currentFluid.displayFluid();
    
    }
    
