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
}

void draw() {
  background(230);
}
 
