// I like to work in inches somethimes so I create
// a variable called 'in' so I can say 1*in instead of 25.4
in=25.4;  
$fs=.5;

// This module makes a solid that is subtracted from the node
// object later I subtract it from truncated sphere but you could replace the
// sphere with anything  For example you could make a buckyball with teddy bear
// nodes.  Or you could make each node a different object.
module bucky_holes()
{
// dia is the diameter of the hole (or size of square hole) that will be created
dia=.075*in; 

// len is the length of the part that will be subtracted really big so
// you prabably wont need to adjust it (unless you are making something huge!)
len= 3*in;
    
// phi is the angle between a hexagon facet edge and 
// the pentagon facet plane in a truncated icosahedron 
phi=31.7175; 

rotate ([0,-phi/2,0])
{
rotate ([0,90,180-54]) hole_shape(len,dia);
rotate ([0,90,-(180-54)]) hole_shape(len,dia);
}

rotate ([0,phi/2,0])
{
rotate ([0,90,0]) hole_shape(len,dia);
}
sphere (dia);
}

// The hole shape module defines the shape of the
// holes created in the node object. square holes
// seemed to work well for the toothpick buckyball
module hole_shape(len,dia)
{
    translate([0,0,len/2])cube([dia,dia,len],center=true);
    //cylinder (len,dia/2,$fn=20); // use this line to make round holes
}

rnode=.40*in;  // Define the radius of the node
dnode=rnode*2; // Set the resulting diameter of the nodes

difference ()
{
    sphere (rnode); //This is the node object (could be a teddybear)
    
    // Rotate the holes to lin them up with the xy plane
    // I just eyeballed where they looked good -4 degrees looks right
    rotate ([0,-4,0]) 
    {
        bucky_holes();
    }
    //trim the top and bottom of the sphere
    //(comment the next two lines to make full sphere nodes.)
    translate ([0,0,-6/8*dnode]) cube([dnode,dnode,dnode],true);
    translate ([0,0,5/8*dnode]) cube([dnode,dnode,dnode],true);
}
//Make the dot indicating which hole is for the hexogon sides.
translate([.34*in,0,1.8])sphere(.05*in);

