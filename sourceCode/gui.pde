/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void mass_change(GSlider source, GEvent event) { //_CODE_:sliderMass:619737:
  println("sliderMass - GSlider >> GEvent." + event + " @ " + millis());
  float newMass = source.getValueF();

  
} //_CODE_:sliderMass:619737:

public void restDensity_change(GSlider source, GEvent event) 
{ //_CODE_:sliderRestDensity:745241:
  println("sliderRestDensity - GSlider >> GEvent." + event + " @ " + millis());
    float newRestDensity = source.getValueF();
} //_CODE_:sliderRestDensity:745241:

public void k_change(GSlider source, GEvent event) 
{ //_CODE_:sliderK:474059:
  println("sliderK - GSlider >> GEvent." + event + " @ " + millis());
  float newK = source.getValueF();  
} //_CODE_:sliderK:474059:

public void fluidViscosity_change(GSlider source, GEvent event) 
{ //_CODE_:sliderFluidViscosity:680732:
  println("sliderFluidViscosity - GSlider >> GEvent." + event + " @ " + millis());
    float newFluidViscosity = source.getValueF();  
} //_CODE_:sliderFluidViscosity:680732:

public void update_click(GButton source, GEvent event) 
{ //_CODE_:btnUpdate:391167:
  println("btnUpdate - GButton >> GEvent." + event + " @ " + millis());
    water.setParticlesNumber(newParticlesNum);
    println("newParticlesNum" + newParticlesNum);
} //_CODE_:btnUpdate:391167:

public void txtParticlesNum_change(GTextField source, GEvent event) 
{ //_CODE_:txtParticlesNum:283906:
  println("txtParticlesNum - GTextField >> GEvent." + event + " @ " + millis());
  newParticlesNum = source.getValueI();
  //water.setParticlesNumber(newParticlesNum);
} //_CODE_:txtParticlesNum:283906:

public void txtTimeStep_change(GTextField source, GEvent event) 
{ //_CODE_:txtTimeStep:694139:
  println("textTimeStep - GTextField >> GEvent." + event + " @ " + millis());
  float newTimeStep = source.getValueF();
} //_CODE_:txtTimeStep:694139:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Controller Window");
  lblHeader = new GLabel(this, 41, 46, 396, 42);
  lblHeader.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblHeader.setText("SPH Fluid Simulation");
  lblHeader.setOpaque(false);
  lblMass = new GLabel(this, 363, 216, 80, 20);
  lblMass.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblMass.setText("Mass");
  lblMass.setOpaque(false);
  lblK = new GLabel(this, 366, 431, 80, 21);
  lblK.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblK.setText("k");
  lblK.setOpaque(false);
  lblRestDensity = new GLabel(this, 364, 325, 80, 20);
  lblRestDensity.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblRestDensity.setText("Rest Density");
  lblRestDensity.setOpaque(false);
  lblFluidViscosity = new GLabel(this, 57, 356, 80, 20);
  lblFluidViscosity.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblFluidViscosity.setText("µ");
  lblFluidViscosity.setOpaque(false);
  sliderMass = new GSlider(this, 350, 246, 100, 53, 10.0);
  sliderMass.setShowValue(true);
  sliderMass.setShowLimits(true);
  sliderMass.setLimits(0.5, 0.0, 1.0);
  sliderMass.setShowTicks(true);
  sliderMass.setNumberFormat(G4P.DECIMAL, 2);
  sliderMass.setLocalColorScheme(GCScheme.RED_SCHEME);
  sliderMass.setOpaque(false);
  sliderMass.addEventHandler(this, "mass_change");
  sliderRestDensity = new GSlider(this, 353, 360, 100, 53, 10.0);
  sliderRestDensity.setShowValue(true);
  sliderRestDensity.setShowLimits(true);
  sliderRestDensity.setLimits(0.5, 0.0, 1.0);
  sliderRestDensity.setShowTicks(true);
  sliderRestDensity.setNumberFormat(G4P.DECIMAL, 2);
  sliderRestDensity.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  sliderRestDensity.setOpaque(false);
  sliderRestDensity.addEventHandler(this, "restDensity_change");
  sliderK = new GSlider(this, 352, 465, 100, 53, 10.0);
  sliderK.setShowValue(true);
  sliderK.setShowLimits(true);
  sliderK.setLimits(0.5, 0.0, 1.0);
  sliderK.setShowTicks(true);
  sliderK.setNumberFormat(G4P.DECIMAL, 2);
  sliderK.setOpaque(false);
  sliderK.addEventHandler(this, "k_change");
  sliderFluidViscosity = new GSlider(this, 47, 391, 100, 51, 10.0);
  sliderFluidViscosity.setShowValue(true);
  sliderFluidViscosity.setShowLimits(true);
  sliderFluidViscosity.setLimits(0.5, 0.0, 1.0);
  sliderFluidViscosity.setShowTicks(true);
  sliderFluidViscosity.setNumberFormat(G4P.DECIMAL, 2);
  sliderFluidViscosity.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  sliderFluidViscosity.setOpaque(false);
  sliderFluidViscosity.addEventHandler(this, "fluidViscosity_change");
  lblParticleOptions = new GLabel(this, 347, 111, 144, 75);
  lblParticleOptions.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblParticleOptions.setText("Particle Options");
  lblParticleOptions.setOpaque(false);
  lblFluidOptions = new GLabel(this, 9, 119, 206, 69);
  lblFluidOptions.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  lblFluidOptions.setText("Fluid Options");
  lblFluidOptions.setOpaque(false);
  btnUpdate = new GButton(this, 192, 837, 80, 35);
  btnUpdate.setText("Update");
  btnUpdate.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  btnUpdate.addEventHandler(this, "update_click");
  txtParticlesNum = new GTextField(this, 48, 219, 120, 30, G4P.SCROLLBARS_NONE);
  txtParticlesNum.setPromptText("Number of Particles");
  txtParticlesNum.setOpaque(false);
  txtParticlesNum.addEventHandler(this, "txtParticlesNum_change");
  txtTimeStep = new GTextField(this, 47, 270, 120, 30, G4P.SCROLLBARS_NONE);
  txtTimeStep.setPromptText("Time Step");
  txtTimeStep.setOpaque(true);
  txtTimeStep.addEventHandler(this, "txtTimeStep_change");
}

// Variable declarations 
// autogenerated do not edit
GLabel lblHeader; 
GLabel lblMass; 
GLabel lblK; 
GLabel lblRestDensity; 
GLabel lblFluidViscosity; 
GSlider sliderMass; 
GSlider sliderRestDensity; 
GSlider sliderK; 
GSlider sliderFluidViscosity; 
GLabel lblParticleOptions; 
GLabel lblFluidOptions; 
GButton btnUpdate; 
GTextField txtParticlesNum; 
GTextField txtTimeStep; 
