import g4p_controls.*;
import java.awt.*;
GWindow Screen;
 
final int N = 256;
final int EMPTY = -1;
final float k = 8.314472; 
float h = 0.5;


//make fluid
final Fluid water = new Fluid();

void settings() 
{
  //size(N, N);
  size(1300, 900, P2D);
}

void setup() {
  createGUI();
  guiModifications();
}

void draw() 
{
  background(230);
  pushMatrix();
  fill(255,255,255);
  rect(600,180,600,500);
  noStroke(); 
  popMatrix();
 
  int i = 0;
    
    for (i = 0; i < 120 ; i++) 
    {
        pushMatrix();
        fill(30,193,250);
        circle(602+i*5, 180, 5);
        noStroke(); 
        fill(30,193,250);
        popMatrix();
    }
}

 
void guiModifications(){
  lblHeader.setFont(new Font("Arial", Font.PLAIN, 30));
  lblParticleOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblFluidOptions.setFont(new Font("Arial", Font.PLAIN, 20));
  lblMass.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblFluidViscosity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblRestDensity.setFont(new Font("Arial", Font.PLAIN, 15)); 
  lblH.setFont(new Font("Arial", Font.PLAIN, 15));
}
