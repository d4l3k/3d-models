
key_width = 16.05;
key_spacing = key_width + 3;
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
plate_thickness = 1.5;

top_padding = 8.65;
side_padding = 7.5;
plate_to_top = 7.5;

usb_width = 15;
usb_position = 0;
row_spacing = 19;

screw_diameter = 3;

module hole() {
  circle(r=hole_size, $fs=0.1);
}

board_height = 76;
board_width = 114;
lip_size = 50;
lip_height = 8.5;

module outline () {
  union() {
    body_height = board_height+top_padding+side_padding;
    square([board_width+2*side_padding,body_height]);
    
    translate([0, body_height]) {
      square([lip_size,lip_height]);
      translate([lip_size, 0])
      polygon([[0,0], [0, lip_height], [lip_height, 0]]);
    }
  }
}

module body() {
  linear_extrude(height=10)
  outline();
}

module edged () {
minkowski()
{
  body();

hull() {
  translate([0,0,1])
rotate_extrude(convexity = 10, $fn=50)
translate([2, 0, 0])
circle(r = 2, $fn=50);
}
}
}

module logo() { 

translate([side_padding, board_height+side_padding+4.5, plate_to_top+plate_thickness-0.5])
linear_extrude(height=5)
scale(0.65)
text("JINB0AT", font="IBM Plex Mono:style=Regular");
  
}

module inner() {
   translate([side_padding, side_padding])
  offset(1, $fn=50)
  offset(-1, $fn=50)
  square([board_width, board_height]);
}

module screw_hole() {
  cylinder(d=screw_diameter, plate_to_top, $fn=6);
}


difference() {
keyboard();
logo();
  
  translate([side_padding/2, side_padding/2]) {
    screw_hole();
    translate([0, board_height+side_padding]) screw_hole();
    
    translate([board_width + side_padding, 0]) {
      screw_hole();
      translate([0, board_height+side_padding]) screw_hole();
    }
  }
}




module layoutfile() {
    import(file="jinboat_keys.dxf");
}

module keyboard() {   
  linear_extrude(plate_to_top + plate_thickness)
    minkowski() {
      difference() {
        offset(4, $fn=50)
          offset(-8, $fn=50)
            offset(4, $fn=50)
              outline();
        
        inner();
      }
      //circle(r=1, $fn=50);
    }

  translate([side_padding-0.1, side_padding-0.3, 0])
    linear_extrude(height=plate_thickness)
      layoutfile();
}  

//layoutfile();
