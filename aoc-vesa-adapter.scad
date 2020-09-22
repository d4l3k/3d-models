vesa = 75;
center_size = 55;

adapter_height = 17.43;
adapter_width = 34.3+0.5;
adapter_length = 45;

beam_size = 20;
base_thickness = 8;
nut_size = 7.1;
hole_size = 4.5;
nut_depth = 2;


module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}



module hole() {
  translate([0,0, -base_thickness/2])
  cylinder(d=hole_size, base_thickness * 2, $fn=20);
  translate([0,0, base_thickness])
  hexagon(nut_size, nut_depth*2);
}

module beam() {
beam_len = vesa * sqrt(2);
square([beam_len, beam_size], center=true);
translate([beam_len/2, 0])
circle(d=beam_size);
translate([-beam_len/2, 0])
circle(d=beam_size);
}

module base() {
square([center_size, center_size], center = true);

rotate(45)
beam();

rotate(-45)
beam();
}

module body() {
difference() {
linear_extrude(base_thickness)
base();
  
translate([vesa/2, vesa/2])
hole();  
translate([vesa/2, -vesa/2])
hole();  
translate([-vesa/2, -vesa/2])
hole();  
 translate([-vesa/2, vesa/2])
hole();  
}

translate([0, 0, adapter_height/2 + 1*base_thickness])
cube([adapter_width+base_thickness*2, adapter_length, adapter_height], center=true);
}


difference() {
  body();

translate([0, 0, adapter_height/2 ])
cube([adapter_width, 2*adapter_width, adapter_height], center=true);
}
