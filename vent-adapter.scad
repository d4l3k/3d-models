// fan

box_depth = 42.46;
box_width = 99.33;
box_length = 139.92 + 106.26;
bevel = 20.58; // short way
bevel_length = 22.11; // long way
top_depth = 6.40;
hole_from_edge = 11.45;
hole_diameter = 3.1; //4.13;

// plate

width = 134;
depth = 7.6;
length = (13+5/8) * 25.4;
plate_hole_from_edge = 11.44;
plate_hole_diameter = 6.13;

plate_thickness = 4;

$fn = 100;

part_width = max(box_width + bevel*2, width);

   module prism(l, w, h){
     translate([-l/2, -w/2, -h/2])
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
              }

module fan_body() {
  translate([0, 0, box_depth/2])
  cube([box_length, box_width, box_depth],center=true);

  translate([0, 0, box_depth + top_depth / 2])
  cube([
    bevel_length*2+box_length, 
    bevel*2+box_width, 
    top_depth
  ], center=true);
}

module fan_holes() {
  for (rot = [0, 180]) {
    rotate([0, 0, rot])
    translate([box_length/2 + bevel_length - hole_from_edge, 0, box_depth+top_depth/2])
    cylinder(h=top_depth*2, d=hole_diameter, center=true);
  }
}



module fan () {
  difference() {
    fan_body();
    fan_holes();
  }
}

//fan();

module plate(width = width) {
  difference () {
    translate([0, 0, depth/2])
      cube([length, width, depth], center=true);
      
    translate([0, 0, depth/2-plate_thickness])
      cube([length-plate_thickness*2, width-plate_thickness*2, depth], center=true);
      
    for (rot = [0, 180]) {
      rotate([0, 0, rot])
        translate([length/2 - plate_hole_from_edge, 0, depth/2])
          cylinder(h=depth*2, d=plate_hole_diameter, center=true);
    }
  }
}

module part_body() {
plate(width=part_width);

translate([0, 0, (box_depth+depth)/2])
cube([
    bevel_length*2+box_length, 
    bevel*2+box_width, 
    box_depth-depth
  ], center=true);
}

//#fan();

difference () {
  part_body();
  
  translate([0, 0, (box_depth+depth)/2])
  cube([
    bevel_length*2+box_length-plate_thickness*2, 
    bevel*2+box_width-plate_thickness*2, 
    box_depth-depth+10
  ], center=true);
}

mount_size = 15;


difference () {
for (rot = [0, 180]) {
  rotate([0, 0, rot])
  translate([box_length/2+bevel_length/2, 0, box_depth-mount_size/2])
  rotate([180, 0, 90])
  prism(mount_size, mount_size, mount_size);
}

translate([0, 0, -top_depth])
fan_holes();
}

support_size = 5;

for (rot = [0, 180]) {
  
  rotate([0, 0, rot])
for (y = [-part_width/4, 0, part_width/4]) {
  
translate([bevel_length+box_length/2-plate_thickness+support_size/2, y, depth/2])
cube([support_size, support_size, depth], center=true);
}
}