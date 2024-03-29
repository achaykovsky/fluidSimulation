# Fluid Simulation, using SPH technique


https://user-images.githubusercontent.com/49001453/119117835-501ad900-ba32-11eb-8c89-d2768b735e84.mp4

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


For the acceleration of particle(i) we get:

![7](https://user-images.githubusercontent.com/49001453/98286265-6688a800-1fac-11eb-922f-b405ee2ba0e8.png)

where vi is the velocity of particle(i) and fi and ρi are the force density field and the density field evaluated at the location of
particle(i), repectively. 

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

__________________________________________________________________________________________________________________________________

However, in this simulation I integerated a different approach using [this article](http://www.ligum.umontreal.ca/Clavet-2005-PVFS/pvfs.pdf)

