vesa = 75;
center_size = 55;

beam_size = 20;
base_thickness = 8;
nut_size = 7.1;
hole_size = 4.5;
nut_depth = 2;

$fn = 100;

vesa_rotation = 20;


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

module vesa_body() {
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
  
  text_depth = 1;
  #translate([-center_size/2+2, beam_size/2, base_thickness-text_depth])
  rotate([0,0, 0])
  linear_extrude(text_depth*2)
  scale(0.7)
  text("Tristan Rice", "Open Sans Condensed:style=Light");
}
}

// insert

insert_thickness = 2;
insert_width = 53.16;
insert_length = 39.64;
top_gap = 15.9;
top_tab_length = 12;
side_tab_width = 7.84;
side_tab_length = 9.8;
hole_pos = 5.71-(40-39.64);
hole_height=6.8;
hole_width=15.9;

adapter_thickness = 13;

vesa_center = 61 + 55;


module insert_base() {
  linear_extrude(insert_thickness)
  difference() {
    square([insert_width, insert_length]);
    
    translate([insert_width/2-hole_width/2, hole_pos])
    square([hole_width, hole_height]);
    
    translate([insert_width/2-top_gap/2, insert_length-top_tab_length])
    square([top_gap, top_tab_length]);
    
    translate([0, side_tab_width])
    square([side_tab_length, insert_length-side_tab_width]);
    
    translate([insert_width-side_tab_length, side_tab_width])
    square([side_tab_length, insert_length-side_tab_width]);
  }

  translate([side_tab_length, 0, insert_thickness])
  cube([insert_width-2*side_tab_length, insert_length-top_tab_length, adapter_thickness]);
}
module adapter() {
translate([insert_width/2, 0, adapter_thickness+insert_thickness+base_thickness])
rotate([0,180])
insert_base();

translate([-insert_width/2+side_tab_length, 0])
cube([insert_width-2*side_tab_length, vesa_center, base_thickness]);

translate([0, vesa_center])
rotate([0, 0, vesa_rotation])
vesa_body();
}

hdmi_height = 13+1;
hdmi_width = 22+1;
hdmi_pos_y = 72;
hdmi_pos_x = 9;

difference() {
  adapter();
  
  // HDMI port
  translate([hdmi_pos_x, hdmi_pos_y])
  cube([hdmi_width, hdmi_height, 100]);
}