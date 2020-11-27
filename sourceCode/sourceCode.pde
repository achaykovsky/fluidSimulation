import g4p_controls.*;
import java.awt.*;
GWindow Screen;
 
final int N = 256;


//make fluid
final Fluid water = new Fluid();

void settings() 
{
  //size(N, N);
  size(500, 900, P2D);
}

void setup() {
  createGUI();
  guiModifications();
}

void draw() {
  background(230);
}
 
 
void guiModifications(){
  lblHeader.setFont(new Font("Arial", Font.PLAIN, 30));
  lblParticleOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblFluidOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblMass.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblK.setFont(new Font("Arial", Font.PLAIN, 15));
  lblFluidViscosity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
}
