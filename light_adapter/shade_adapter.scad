include <threads.scad>

lip_outer = 53.32; // outer lip diameter
lip_inner = 42; // inner diameter
lip_narrow = 50.82; // narrow below lip
lip_height = 10+1; // height of lip and narrow


shade_inner = 42;
shade_thickness = 2.5;

bulb_thread = 26;
bulb_wide = 33;

thickness = 3;
outer = 50;
tol = 0.5;

$fn = 200;
height = 3*thickness + lip_height;

thread_tol = 1.4;

module base() {
  cylinder(h=thickness+shade_thickness, d=shade_inner-tol);
  cylinder(h=thickness, d=outer);
  
  
  translate([0, 0, thickness+shade_thickness])
  ScrewThread(shade_inner, lip_height, pitch=2);
}

difference() {
  base();

  translate([0, 0, -5])
  cylinder(h=height*2, d=shade_inner-thickness*2);
}

module ring() {
  cylinder(h=lip_height, d=lip_narrow);
  cylinder(h=2, d=lip_outer);
}

translate([60, 0, 0])
difference() {
  ring();  

  
  ScrewThread(shade_inner + thread_tol, lip_height, pitch=2);
}



