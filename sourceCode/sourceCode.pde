import g4p_controls.*;
import java.awt.*;
GWindow Screen;
 
final int EMPTY = -1;
final float k = 8.314472; 


//make fluid
final Fluid fluid = new Fluid();

void settings() 
{
  size(1300, 900, P2D);
}

void setup() 
{
  createGUI();
  guiModifications();
}

void draw() 
{
  background(230);
  fill(255,255,255);
  stroke(0,0,0);
  rect(600,180,600,500);
  
      for (Particle p : fluid.particles) 
      {
        //fluid.grid.particlesMatrix(fluid.particles);
        //fluid.grid.sortParticles(fluid.particles);
        //fluid.grid.initialize(fluid.particles);
        //fluid.calculatePressure(); //<>//
        //fluid.calculateForces();
        p.updateVelocity(fluid.timeStep);
        p.display(fluid.h);
        fluid.boundaries();
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
  lblMass.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblFluidViscosity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblH.setFont(new Font("Arial", Font.PLAIN, 15));
  lblParticlesNum.setText("Number Of Particles: " + fluid.particlesNumber);
  lblParticlesNum.setFont(new Font("Arial", Font.PLAIN, 15));
  lblSimulation.setFont(new Font("Arial", Font.PLAIN, 20));
  lblSimulation.setLocalColorScheme(0);
  lblCurrent.setFont(new Font("Arial", Font.PLAIN, 18));
  lblCurrent.setLocalColorScheme(0);
  lblCurrMass.setText("Mass: " + fluid.particles[0].getMass());
  lblCurrMass.setFont(new Font("Arial", Font.PLAIN, 15));
  lblcurrH.setText("h: " + fluid.h);
  lblcurrH.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrRestDensity.setText("Rest Density: " + fluid.getRestDensity());
  lblCurrRestDensity.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrMyu.setText("µ: " + fluid.particlesNumber);
  lblCurrMyu.setFont(new Font("Arial", Font.PLAIN, 15));
  lblCurrTimeStep.setText("Time Step: " + fluid.timeStep);
  lblCurrTimeStep.setFont(new Font("Arial", Font.PLAIN, 15));
}
