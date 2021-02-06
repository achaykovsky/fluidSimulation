# Fluid Simulation, using SPH technique

## First Week: 
1. Started a repository.
2. Read background physics material.
3. Watched a few lectures about SPH.  [Part I](https://www.youtube.com/watch?v=tAXHCAEgSuE&ab_channel=MonashAstro) [Part II](https://www.youtube.com/watch?v=OTlygbegQT4&ab_channel=MonashAstro)
4. Studied basic features and viewed tutorials of Processing.

## Second Week:
1. Made a summary of SPH based on the article attached [here.](https://people.cs.clemson.edu/~dhouse/courses/817/papers/mueller03.pdf)
2. Started the particle class. Implemented the basics: variables and getters/setters.

## Third Week:
1. Added some details to the summary.
2. Updated some properties of the paticle class.
3. Started the forces class. Implemented the constants and the forces: pressure and viscosity.

## Fourth Week:
1. Added the basic GUI.
2. Updated the particle class.

## Fifth Week:
1. Updated the GUI.
2. Added acceleration to the particle class.
3. Added the basics for the fluid class.
4. Added the forces class (Calculations of pressure and viscosity using SPH Kernels).

## Sixth Week:
1. Updated the GUI and changed to the right intervals.
2. Started the draw part (the particles).
3. Started to work on the boundaries.
4. Started to work on the total calculations of the forces equation.
*parts 2-4 are under construction and haven't been commited yet.

## Seventh Week:
1. Updated the particle
2. Still working on parts 2-4 from last week to make everything work together.

## Eighth Week:
1. Defined the size of the simulation window.
2. Defined the walls by it.
3. Drew the simulation.
4. Working on making the particles move.

## Nineth Week:
Looking for the things that prevent the simulation from working.

## Tenth Week:
1. Fixed a bug that crashed the program.
2. Working on the things that prevent the simulation from working.

## Eleventh Week:
1. Discovered an important and tricky bug that prevents the whole simulation from working.
2. Started to fix it through the program.
3. Updated the main window of the simulation (shows the current parameters for the convenience of the user).

## Twelfth Week:
1. Fixed some issues on the particle class which prevented the simulation from moving.
2. Updated the GUI and fixed some errors there.
3. Found sources about how to integrate a grid into the simulation.
4. Created the grid (working on it).
5. On work: Forces and Fluid classes have some issues with updating the parameters

## Thirteen Week:
1. Fixed some issues on the particle class which prevented the simulation from moving.
2. Integrated the grid
3. Added surface tension force (not commited yet).
4. Fixed a bug on the forces class (prevented simulation from running).

## Fourteen Week:
Added some description about surface tension.
Exams period - took a break from programming.

## Fifteen Week:
1. Updated the Simulation size (including boundaries etc.)
2. Added new conrollers (Play/Pause/Reset).
3. Fixed the update button.

# SPH Summary
The summary is based on the article that is attached [here.](https://people.cs.clemson.edu/~dhouse/courses/817/papers/mueller03.pdf)

SPH is an interpolation method for particle systems. With SPH, field quantities that are only defined at discrete particle locations can be evaluated anywhere in space.
SPH distributes quantities in a local neighborhood of each particle using radial symmetrical smoothing kernels.
According to SPH, a scalar quantity A is interpolated at location r by a weighted sum of contributions from all particles:

![image](https://user-images.githubusercontent.com/49001453/98122232-f6e5c080-1eb8-11eb-83ba-0836c907f441.png)

where j iterates over all particles, mj is the mass of particle j, rj its position, ρj the density and Aj the field quantity at rj.
The function W(r,h) is called the smoothing kernel with core radius h.
To calculate the gradient of it, we apply it the same equation on all axis.

![2](https://user-images.githubusercontent.com/49001453/98284458-d34e7300-1fa9-11eb-9d9e-bc9ff599c8db.png)

Each particle i represents a certain volume Vi = mi/ρi.
While the mass mi is constant throughout the simulation and, in our case, the same for all the particles, the density ρi varies and needs
to be evaluated at every time step. Therefore, the density at location r:

![3](https://user-images.githubusercontent.com/49001453/98284553-f4af5f00-1fa9-11eb-8d3e-ebb263c8a785.PNG)

There are three force density fields, modeling pressure (∇p), external forces (ρg) and viscosity (µ∇2v).
The sum of these force density fields determines the change of momentum:

![4](https://user-images.githubusercontent.com/49001453/98285437-37be0200-1fab-11eb-8f62-e8e29d88c791.png)

Application of the SPH rule to the pressure term ∇p yields:

![5](https://user-images.githubusercontent.com/49001453/98285862-d21e4580-1fab-11eb-9e4e-b0d7c5abeb79.PNG)

This pressure force is symmetrized because it uses arithmetic mean of the pressures of interacting particles.

![6](https://user-images.githubusercontent.com/49001453/98286106-275a5700-1fac-11eb-91e2-981fa993143a.PNG)

The viscosity forces are symmetrized using the velocity differences.


For the acceleration of particle i we get:

![7](https://user-images.githubusercontent.com/49001453/98286265-6688a800-1fac-11eb-922f-b405ee2ba0e8.png)

where vi is the velocity of particle i and fi and ρi are the force density field and the density field evaluated at the location of
particle i, repectively. 

The pressure can be computed via the ideal gas state equation.

![8](https://user-images.githubusercontent.com/49001453/98286435-af406100-1fac-11eb-9ba9-eaea6128dd90.png)

In our case, k will be a fluid constant and ρ0 is the rest density.

For the computation of common kernel forces we used this formula:

![17 - W - 1](https://user-images.githubusercontent.com/49001453/98481255-a8f6f280-2201-11eb-9899-e8347fb2cf3f.PNG)

For the computation of viscosity forces we used this formula:

![18 - W - 2](https://user-images.githubusercontent.com/49001453/98481271-c2983a00-2201-11eb-97c4-0a782cc98f22.PNG)

As particles get very close to each other, the repulsion force vanishes because the gradient of the kernel approaches zero at the center. Desbrun solves
this problem by using a spiky kernel with a non vanishing gradient near the center. For pressure computations I use Debrun's spiky kernel:

![19 - W - 3](https://user-images.githubusercontent.com/49001453/98481277-ce83fc00-2201-11eb-9be0-f60f277b5bfc.PNG)

For the smoothed color field we get:

![image](https://user-images.githubusercontent.com/49001453/105640462-e07f4d80-5e86-11eb-849e-c10e4da24532.png)

The gradient field of the smoothed color field:

![image](https://user-images.githubusercontent.com/49001453/105640473-f42ab400-5e86-11eb-9d35-584531e76a94.png)
 
yields the surface normal field pointing into the fluid and the divergence of n measures the curvature of the surface

 ![image](https://user-images.githubusercontent.com/49001453/105640476-f7be3b00-5e86-11eb-8e02-2a186d5cc204.png)

The minus is necessary to get positive curvature for convex fluid volumes. Putting it all together, we get for the surface traction:

![image](https://user-images.githubusercontent.com/49001453/105640481-fab92b80-5e86-11eb-969b-3edb6e0d2b00.png)
 
To distribute the surface traction among particles near the surface and to get a force density we multiply by a normalized scalar field δs = |n| which is non-zero only near the surface. For the force density acting near the surface we get:

![image](https://user-images.githubusercontent.com/49001453/105640482-fdb41c00-5e86-11eb-9967-fe41ee2d4a76.png) 
 
Evaluating n=|n| at locations where |n| is small causes numerical problems. We only evaluate the force if |n| exceeds a certain threshold.