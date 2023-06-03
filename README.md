# Wandering-Terrain-in-Godot-4
## Introduction and Resources
A loose implementation of the ClipPlane "Wandering" Terrain as seen here by Devmar: https://www.youtube.com/watch?v=rcsIMlet7Fw 
Thanks for Winston who helped me with some annoying math!

Right now this includes:
* My very plane mesh, which is more subdivided closer to the middle
* A heightmap collision shape node that will take your shader's noise texture, and runs a function to calculate the height. Of course, you can modify it.
## Example
The included example is just a simple scene with the Terrain instance. There is also an example of basic UV offsetting to get the infinite generation effect in "WanderingTerrainProgress.gd".
