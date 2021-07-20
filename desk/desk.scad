use <roundedcube.scad>;

$fn=100;

leg_offset = 27.5;
leg_height = 25;
leg_width = 4;
leg_inner = 3;


post_width = 2.9;


module leg() {
    translate([0, 0, -leg_height/2])
  
  difference() {
  cube([leg_width, leg_width, leg_height], center=true);
  cube([leg_inner, leg_inner, leg_height*2], center=true);

  }
}

module foot() {
    translate([0, 0, -leg_height])

    cube([leg_width, 27.5, 2], center=true);
  
  translate([0, 0, -leg_height/2])
    cube([post_width, post_width, leg_height], center=true);


}

module top() {

scale([1, 1, 1/10])
roundedcube([70, 30, 0], true, 5, "z");



for (x = [-leg_offset, leg_offset]) {
  translate([x, 0, 0]) {
     leg();

  }
}
}

module bottom() {
  translate([0, 0, -leg_height-0.5-1])
  cube([leg_offset*2, 4, 1], center=true);
for (x = [-leg_offset, leg_offset]) {
  translate([x, 0, -1]) {
    foot();
  }
}
}
//top();
bottom();