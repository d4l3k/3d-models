
screw_od = 4.05;
screw_head = 9.10 + 1;
screw_pos = 17;

base_width = 13.04;
base_width = 13.5;
base_length = 23;
base_height = 7.00;
hole_height = 4.70;

arm_extension = 1.5;
head_width = 8.13;
arm_od = 25;
arm_id = 11;
arm_width = (arm_od-arm_id)/2;


hole_to_surface = 15.33;
hole_to_end = 3.5; 

$fn = 100;


module arm() {
    translate([arm_extension, 0, 0])
    difference() {
        cylinder(h=base_height, d=arm_od);
        translate([0, 0,  -1])
        cylinder(h=base_height+2, d=arm_id);
        
        translate([-arm_od, -arm_od/2, -arm_od/2])
        cube([arm_od, arm_od, arm_od]);
    }
    
    translate([0, arm_id/2])
    cube([arm_extension, arm_width, base_height]); 
    translate([0, -arm_od/2])
    cube([arm_extension, arm_width, base_height]);       
    
}
module screw_hole() {
    translate([0, 0, -1])
    cylinder(h=base_height, d=screw_od);
    translate([0, 0, hole_height])
    cylinder(h=base_height, d=screw_head);

}

difference() {
    cube([
       base_length,
       base_width,
       base_height,
    ]);
    
    translate([
      screw_pos,
      base_width/2,
    ])
    screw_hole();
}

head_x = screw_pos-hole_to_end;
head_length = base_length-head_x;
head_y = hole_to_surface+base_width/2;
translate([
  head_x,
  head_y,
  0,
])
#cube([
  head_length,
  arm_width, 
  base_height,
]);

translate([
  base_length,
  head_y-arm_id/2,
  0])
arm();