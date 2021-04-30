clock_diameter = 2.9375;
width = 3.5;
depth = 0.75;
height = 4;

base_width = 5.5;
base_height = 0.5;
base_depth = 3;
base_angle = 15;

in_to_mm = 2.54 * 10;

$fn = 200;

module model() {
difference() {
  // clock frame
  translate([0, 0, height/2])
  cube([width, depth, height], center=true);
  
  // clock hole
  margin = (width-clock_diameter)/2;
  translate([0, 0, clock_diameter/2+margin])
  rotate([90])
  cylinder(h=2*depth, d=clock_diameter, center=true);
}

// base
translate([0, 0, height])
rotate([base_angle, 0, 0])
cube([base_width, base_depth, base_height], center=true);
}

scale(in_to_mm)
model();