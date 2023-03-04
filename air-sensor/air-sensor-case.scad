include <2.7in-epaper-hat.scad>


wall_thickness = 2;
wire_space = 5;
case_length = pcb_length + wall_thickness*2 + wire_space;
case_height = pcb_height + wall_thickness*2;
case_depth = 20;

translate([-wall_thickness, -wall_thickness, -wall_thickness])

difference() {
  {
    cube([case_length, case_height, wall_thickness+case_depth]);
    cube([case_length, case_height, wall_thickness+case_depth]);

  }
  
  translate([wall_thickness*2, wall_thickness*2, wall_thickness])
  cube([case_length-wall_thickness*4, case_height-wall_thickness*4, case_depth*2]);
}



translate([pcb_length, 0, case_depth])
rotate([180, 0, 180])
eink();

translate([50, 30, 0])
import("3660 BME680.stl");

import("4632 PMSA003I.stl");

translate([70, 40, 0])
rotate([0, 0, -90])
import("5405 QTPy ESP32 C3.stl");
