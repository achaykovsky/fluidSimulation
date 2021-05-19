class GeneralProperties
{
       void initializeParams()
       {
          currentFluid.h = 10; 
          currentFluid.timeStep = 2;
          stepsPerFrame = 1;
          mousePressedTimes = 5;
       }
       
      void guiModifications()
      {
        lblHeader.setFont(new Font("Arial", Font.PLAIN, 30));
        lblHeader.setLocalColorScheme(0);
        lblParticleOptions.setFont(new Font("Arial", Font.PLAIN, 20));
        lblParticleOptions.setLocalColorScheme(2);
        lblFluidOptions.setFont(new Font("Arial", Font.PLAIN, 20));
        lblFluidOptions.setLocalColorScheme(2);
        lblViscosityOptions.setFont(new Font("Arial", Font.PLAIN, 20));
        lblViscosityOptions.setLocalColorScheme(2);
        lblStepsPerFrame.setFont(new Font("Arial", Font.PLAIN, 15));
        lblBeta.setFont(new Font("Arial", Font.PLAIN, 15));
        lblSigma.setFont(new Font("Arial", Font.PLAIN, 15)); 
        lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
        lblH.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrParticlesNum.setText("Number Of Particles: " + currentFluid.particles.size());
        lblCurrParticlesNum.setFont(new Font("Arial", Font.PLAIN, 15));
        lblSimulation.setFont(new Font("Arial", Font.PLAIN, 20));
        lblSimulation.setLocalColorScheme(0);
        lblCurrent.setFont(new Font("Arial", Font.PLAIN, 18));
        lblCurrent.setLocalColorScheme(0);
        lblCurrSigma.setText("σ: " + String.format("%.2f",currentFluid.sigma));
        lblCurrSigma.setFont(new Font("Arial", Font.PLAIN, 15));
        lblcurrH.setText("h: " + String.format("%.2f",currentFluid.getH()));
        lblcurrH.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrRestDensity.setText("Rest Density: " + String.format("%.2f",currentFluid.getRestDensity()));
        lblCurrRestDensity.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrBeta.setText("β: " + String.format("%.3f",currentFluid.beta));
        lblCurrBeta.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrTimeStep.setText("Time Step: " + String.format("%.2f",currentFluid.timeStep));
        lblCurrTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
        lblTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
        lblAddNewParticles.setFont(new Font("Arial", Font.PLAIN, 15));
        lblParticlesNumber.setFont(new Font("Arial", Font.PLAIN, 20));
        lblParticlesNumber.setLocalColorScheme(2);
        lblMouseParticles.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrStepsPerFrame.setText("Steps Per Frame: " + String.format("%d",stepsPerFrame));
        lblCurrStepsPerFrame.setFont(new Font("Arial", Font.PLAIN, 15));
        lblCurrParticlesMouseClick.setText("On Mouse Click Particles: " + String.format("%d",mousePressedTimes));
        lblCurrParticlesMouseClick.setFont(new Font("Arial", Font.PLAIN, 15));
        
    }
   
  //currentSimulation.setStepsPerFrame(stepsPerFrameSlider.getValueI());
     void setStepsPerFrame(int _stepsPerFrame)
     {
       stepsPerFrame = _stepsPerFrame;
        for (int i = 0; i < _stepsPerFrame; i++) 
          currentFluid.simulationStep();
     }
     
     void setMousePressedTimes(int _mousePressedTimes)
     {
       mousePressedTimes = _mousePressedTimes;
       if (mousePressed) 
       {
          for (int i = 1; i <= _mousePressedTimes; i++) 
          {
            if ((mouseX > xMin) && (mouseX < xMax) && (mouseY > yMin) && (mouseY < yMax))
              currentFluid.particles.add(new Particle(mouseX + random(kernelRadius), mouseY + random(kernelRadius), false));
          }
        }
      }
  
  
}
