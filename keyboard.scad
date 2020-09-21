
key_spacing = 19.05;
rows = 3;
columns = 10;

padding = 5;

holes_x = 5;
holes_y = 3;
hole_size = 1;
corner_radius = 7;
inner_corner_radius = 2;
thickness = 3;
outer_padding = 1;

usb_width = 15;
usb_position = 0;

module hole() {
  circle(r=hole_size, $fs=0.1);
}

module roundsquare(width, height, radius=0) {
  translate([-width/2, -height/2])
  union() {
    translate([0, radius]) square([width, height-radius*2]);
    translate([radius, 0]) square([width-radius*2, height]);
    translate([radius, radius]) circle(r=radius, $fs=0.1);
    translate([width-radius, height-radius]) circle(r=radius, $fs=0.1);
    translate([radius, height-radius]) circle(r=radius, $fs=0.1);
    translate([width-radius, radius]) circle(r=radius, $fs=0.1);
  }
}

module combokey() {
  height = 14;
  width = 14;
  union (){
    padding_h = 0.6;
    padding_w = 0.8;
    
    translate([-width/2, -height/2]) 
    square([width, height]);
    
    outer_w = width+padding_w*2;
    outer_h = height-padding_h*2;
    translate([-outer_w/2, -outer_h/2]) 
    square([outer_w, outer_h]);
  }
}

module mxkey() {
  height = 14;
  width = 14;
  padding_h = 1;
  padding_w = 0.8;
  inner = 5.8;

  difference () {
    union () {
      translate([-width/2, -height/2]) 
      square([width, height]);
      
      outer_w = width+padding_w*2;
      outer_h = height-padding_h*2;
      translate([-outer_w/2, -outer_h/2]) 
      square([outer_w, outer_h]);
    }
    
    translate([width/2, -inner/2])
    square([padding_w*2, inner]);
    
    translate([-padding_w*2-width/2, -inner/2])
    square([padding_w*2, inner]);
  }
}

module row(n = columns) {
  translate([-key_spacing*(n-1)/2, 0])
  for ( i = [0 : n-1] ) {
    translate([key_spacing * i, 0]) mxkey();
  }
}

module layout (n = rows) {
  translate([0, -key_spacing*(n-1)/2])
  for ( i = [0 : n-1]) {
    translate([0, key_spacing * i]) row();
  }
}

module holes(width, height) {
  hole_spacing_x = width/(holes_x-1);
  hole_spacing_y = height/(holes_y-1);
  translate([-width/2, -height/2])
  for (i = [0 : holes_x-1]) {
    for (j = [0 : holes_y-1]) {
      if (i == 0 || j == 0 || i == holes_x-1 || j == holes_y-1) {
        translate([hole_spacing_x * i, hole_spacing_y * j]) 
        hole();
      }
    }
  }
}

width = columns*key_spacing;
height = rows*key_spacing;

module usbtop() {
  translate([width*usb_position/2-usb_width/2, 0])
  square([usb_width, 1000]);
}
module usbside() {
  translate([0, height*usb_position/2-usb_width/2])
  square([10000000, usb_width]);
}


module base(extra=0, usb=false) {
  difference() {
    roundsquare(
      width + (padding+extra+outer_padding)*2, 
      height + (padding+extra+outer_padding)*2,
      corner_radius+extra
    );
    
    if (usb) {
      usbside();
    }
    
    holes(width+padding, height+padding);
  }
}

module inner(extra=0, usb=false) {
  difference() {
    base(extra, usb);
    
    roundsquare(width, height, inner_corner_radius);
  }
}

module plate(extra=0) {
  difference () {
    base(extra);
    
    layout();
  }
}

/*
translate([0, -100]) base();
plate();
translate([0, 100]) inner();
*/


linear_extrude(thickness) base(0);
translate([0, 0, 1*thickness]) linear_extrude(thickness) inner(2, true);
translate([0, 0, 2*thickness]) linear_extrude(thickness) inner(3.5, true);
translate([0, 0, 3*thickness]) linear_extrude(thickness) plate(4.5);
translate([0, 0, 4*thickness]) linear_extrude(thickness) inner(3.5);
translate([0, 0, 5*thickness]) linear_extrude(thickness) inner(2);
translate([0, 0, 6*thickness]) linear_extrude(thickness) inner(0);


/*
base(0);
translate([0, 80]) inner(2, true);
translate([0, 160]) inner(3.5, true);
translate([0, 240]) plate(4.5);
translate([0, 320]) inner(3.5);
translate([0, 400]) inner(2);
translate([0, 480]) inner(0);
*/


