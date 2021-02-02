import g4p_controls.*;
import java.awt.*;
GWindow Screen;
 
final int EMPTY = -1;
final float k = 8.314472; 

//make fluid
Fluid currentFluid = new Fluid();


void settings() 
{
  size(1300, 900, P2D);
}

void setup() 
{
  createGUI();
}

void draw() 
{
  background(230);
  fill(255,255,255);
  stroke(0,0,0);
  rect(600,180,600,500);
  //println("draw: currentFluid:" + currentFluid.particles.length);
  for (Particle p : currentFluid.particles) 
  {
    currentFluid.grid.particlesMatrix(currentFluid.particles);
    currentFluid.grid.sortParticles(currentFluid.particles);
    currentFluid.grid.initialize(currentFluid.particles);
    currentFluid.calculatePressure(); //<>//
    currentFluid.calculateForces();
    p.updateVelocity(currentFluid.getTimeStep());
    currentFluid.boundaries();
    p.display(currentFluid.h);
   }
  guiModifications();
}

 
void guiModifications()
{
  lblHeader.setFont(new Font("Arial", Font.PLAIN, 30));
  lblHeader.setLocalColorScheme(0);
  lblParticleOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblParticleOptions.setLocalColorScheme(2);
  lblFluidOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblFluidOptions.setLocalColorScheme(2);
  lblMass.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblFluidViscosity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblH.setFont(new Font("Arial", Font.PLAIN, 15));
  lblParticlesNum.setText("Number Of Particles: " + currentFluid.getParticlesNumber());
  lblParticlesNum.setFont(new Font("Arial", Font.PLAIN, 15));
  lblSimulation.setFont(new Font("Arial", Font.PLAIN, 20));
  lblSimulation.setLocalColorScheme(0);
  lblCurrent.setFont(new Font("Arial", Font.PLAIN, 18));
  lblCurrent.setLocalColorScheme(0);
  lblCurrMass.setText("Mass: " + String.format("%.2f",currentFluid.particles[0].getMass()));
  lblCurrMass.setFont(new Font("Arial", Font.PLAIN, 15));
  lblcurrH.setText("h: " + String.format("%.2f",currentFluid.getH()));
  lblcurrH.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrRestDensity.setText("Rest Density: " + String.format("%.2f",currentFluid.getRestDensity()));
  lblCurrRestDensity.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrMyu.setText("µ: " + String.format("%.2f",currentFluid.getFluidViscosity()));
  lblCurrMyu.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrTimeStep.setText("Time Step: " + currentFluid.getTimeStep());
  lblCurrTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
}
