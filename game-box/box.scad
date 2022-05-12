
in = 2.54 * 10;
height = 2 * in;
width = 6 * in;
depth = 5 * in;

wall = 2;

thread = 3;
thread_height = 20;
head = 6;
head_height = 6;

pillar = head + wall*2;

bottom_size = head_height+wall;
$fn = 100;

module box() {
for (x=[0, width-pillar]) {
  for (y=[0, depth-pillar]) {
    
    translate([x, y])
    difference () {
      cube([pillar, pillar, height]);
    }
  }
}


difference() {
  cube([width, depth, height]);
  
  translate([wall, wall, wall])
  cube([width-wall*2, depth - wall*2, height - wall*2]);
  
}
}

module box_holes() {
  difference () {
    box();
    
    for (x=[0, width-pillar]) {
      for (y=[0, depth-pillar]) {
       translate([x+head/2+wall, y+head/2+wall, -5])
        cylinder(d=head, h=head_height+5);
       translate([x+head/2+wall, y+head/2+wall])
        cylinder(d=thread, h=thread_height);

      }
    }
  }
}

module top() {
  difference() {
    box_holes();
    translate([-10, -10, -10])
      cube([width+20, depth+20, bottom_size+10]);
  }
}

module bottom() {
  difference() {
    box_holes();
    translate([-10, -10, bottom_size])
      cube([width+20, depth+20, 10000]);
  }
}


top();
//bottom();
//box_holes();

