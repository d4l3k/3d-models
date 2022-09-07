$fn=100;

thread = 1/4 * 2.54*10;
puck_d = 103.3;
puck_h = 2.54*10;
puck_hole_d = 7.1;

recess_h = 2.54*10 * 1/4;
recess_d = 2.54*10;

pin_d = 5/32 * 2.54 * 10;
pin_spacing = 88.9;
pin_depth = 5.5;

flange_size = 2.54*10;
flange_height = 2.54*10;

module base() {
  cylinder(puck_h, r=puck_d/2);
  
  translate([-(puck_d+flange_size*2)/2, -flange_size, 0])
  cube([puck_d+flange_size*2, flange_size*2, flange_height]);
  
  for (i = [-1, 1]) {
    translate([i * pin_spacing/2, 0, puck_h])
    cylinder(pin_depth, r=pin_d/2);
  }
}
difference() {
  base();
  
  for (i = [-1, 0, 1]) {
    translate([i * (flange_size/2 + puck_d/2), 0, -5])
    cylinder(1000, r=thread/2);
  }
  translate([0, 0, -recess_h])
  cylinder(recess_h*2, r=recess_d/2);
}
  

