button_diameter = 30.30;
power_button_diameter = 15.86;

speaker_hole_size = 2.6;
speaker_x = 24.3;
speaker_y = 63.8;
slot_count = 8;
slot_width = 4;

$fn = 100;

module screw_hole() {
  cylinder(d=speaker_hole_size, 20);
}
module speaker_hole() {
  for ( i = [0 : slot_count] ) {
    translate([0, (i+1) * speaker_y / (slot_count+2) - slot_width/2])
    cube([speaker_x, slot_width, 20]);
  }
  
  screw_hole();
  
  translate([speaker_x, 0])
  screw_hole();
  
  translate([speaker_x, speaker_y])
  screw_hole();
  
  translate([0, speaker_y])
  screw_hole();
}


module part() {
difference() {
translate([-4, -6])
import("Front_Panel_and_Bottom.stl", convexity=3);




translate([-185, 200, 20])
rotate([-90, 0, 0])
cylinder(d=power_button_diameter, 20);
  
  translate([-55, -1, 26])
rotate([-90, 0, 0])
cylinder(d=button_diameter, 20);

translate([-158, -1, 26])
rotate([-90, 0, 0])
cylinder(d=button_diameter, 20);
  
  
translate([-106 + speaker_y/2, 40, -1])
rotate([0, 0, 90])
speaker_hole();


}
}

part();