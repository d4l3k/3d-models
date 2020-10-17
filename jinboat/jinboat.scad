include <BOSL/constants.scad>
use <BOSL/masks.scad>

corner_radius = 4;
inner_corner_radius = 1;
thickness = 3;
outer_padding = 1;
plate_thickness = 1.5;

top_padding = 8.65;
side_padding = 7.5;
plate_to_top = 7.5+1;

screw_diameter = 3;
screw_offset = 0.5;

module hole() {
  circle(r=hole_size, $fs=0.1);
}

board_height = 76+1;
board_width = 114+1;
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

module logo() { 
  font_scale = 0.55;
  translate([side_padding-inner_fillet, board_height+side_padding+4.5, plate_to_top+plate_thickness-1])
    linear_extrude(height=2)
      scale(font_scale) {
        font = "Egge Sans:style=Bold";
        text("t", font=font);
        translate([7.5+1/font_scale, 0])
          text("rifØrce", font=font);
      }
}

module inner() {
   translate([side_padding, side_padding])
  offset(inner_corner_radius, $fn=50)
  offset(-inner_corner_radius, $fn=50)
  square([board_width, board_height]);
}

module screw_hole() {
  cylinder(d=screw_diameter, plate_to_top, $fn=6);
}


module top() {
  difference() {
    keyboard();
    logo();
    
    translate([side_padding/2+screw_offset, side_padding/2+screw_offset]) {
      screw_hole();
      translate([0, board_height+side_padding-screw_offset*2]) screw_hole();
      
      translate([board_width + side_padding-screw_offset*2, 0]) {
        screw_hole();
        translate([0, board_height+side_padding-screw_offset*2]) screw_hole();
      }
    }
    
    fillet();
  }
}



module layoutfile() {
    import(file="jinboat_keys.dxf");
}

module keyboard() {   
  linear_extrude(plate_to_top + plate_thickness)
    minkowski() {
      difference() {
        offset(corner_radius, $fn=50)
          offset(-corner_radius*2, $fn=50)
            offset(corner_radius, $fn=50)
              outline();
        
        inner();
      }
      //circle(r=1, $fn=50);
    }
    
  translate([side_padding, side_padding])
  difference() {
    inner_lip = 2;
    cube([board_width, board_height, plate_thickness]);
    translate([inner_lip/2, inner_lip/2, -plate_thickness*0.5])
    cube([board_width-inner_lip, board_height-inner_lip, plate_thickness*2]);
  }

  translate([side_padding-0.1+0.5, side_padding-0.3+0.5, 0])
    linear_extrude(height=plate_thickness)
      layoutfile();
}  

outer_fillet = 2;
inner_fillet = 1;

$fn=50;

module fillet() {
  translate([0,0, plate_thickness+plate_to_top]) {
    // outer fillet
    // sides
    fillet_mask_x(l=200, r=outer_fillet, align=V_RIGHT, $fn=50);
    fillet_mask_y(l=300, r=outer_fillet, $fn=50);
    translate([board_width+side_padding*2, 0])
    fillet_mask_y(l=300, r=outer_fillet, $fn=50);
      
    translate([0, board_height+side_padding+top_padding]) {
      translate([0,lip_height])
      fillet_mask_x(l=200, r=outer_fillet, align=V_RIGHT, $fn=50);
      
      
      translate([lip_size+lip_height+corner_radius*0.41,0])
      fillet_mask_x(l=200, r=outer_fillet, align=V_RIGHT, $fn=50);
      
      translate([lip_size,lip_height])
      rotate(-45)
      fillet_mask_x(l=lip_height*sqrt(2)-corner_radius*0.41, r=outer_fillet, align=V_RIGHT, $fn=50);
    }
    
    // corners
    translate([corner_radius, corner_radius])
    corner_fillet();
    
    translate([board_width+side_padding*2-corner_radius, corner_radius])
    rotate(90)
    corner_fillet();
    
    translate([board_width+side_padding*2-corner_radius, board_height+side_padding+top_padding-corner_radius])
    rotate(180)
    corner_fillet();
    
    translate([corner_radius, board_height+side_padding+top_padding+lip_height-corner_radius])
    rotate(270)
    corner_fillet();
    
    translate([lip_size-corner_radius*0.41, board_height+side_padding+top_padding+lip_height-corner_radius])
    rotate(180)
    corner_fillet(45);
    
    translate([lip_size+lip_height+corner_radius*0.42, board_height+side_padding+top_padding+corner_radius])
    fillet_hole_mask(r=corner_radius, fillet=outer_fillet, $fn=100);
    
    // inner fillet
    translate([side_padding+inner_corner_radius, side_padding])
    fillet_mask_x(l=board_width-inner_fillet*2, r=inner_fillet, align=V_RIGHT, $fn=50);
    translate([side_padding+inner_corner_radius, side_padding+board_height])
    fillet_mask_x(l=board_width-inner_fillet*2, r=inner_fillet, align=V_RIGHT, $fn=50);
    translate([side_padding, side_padding+inner_corner_radius])
    fillet_mask_y(l=board_height-inner_fillet*2, r=inner_fillet, align=V_BACK, $fn=50);
    translate([side_padding+board_width, side_padding+inner_corner_radius])
    fillet_mask_y(l=board_height-inner_fillet*2, r=inner_fillet, align=V_BACK, $fn=50);
    
    // corners
    translate([side_padding+inner_corner_radius, side_padding+inner_corner_radius])
    inner_corner_fillet();
    
    translate([side_padding-inner_corner_radius+board_width, side_padding+inner_corner_radius])
    inner_corner_fillet();
    
    translate([side_padding-inner_corner_radius+board_width, side_padding-inner_corner_radius+board_height])
    inner_corner_fillet();
    
    translate([side_padding+inner_corner_radius, side_padding-inner_corner_radius+board_height])
    inner_corner_fillet();
  }
}

module inner_corner_fillet() {
  fillet_hole_mask(r=inner_corner_radius, fillet=inner_fillet);
}

module corner_fillet(ang=90) {
  rotate(-90)
  difference() {
      fillet_cylinder_mask(r=corner_radius, fillet=outer_fillet, $fn=100);
  angle_pie_mask(ang=360-ang, d=20, l=10);
  }
}
front_thickness = 6.5;
bottom_thickness = 15.5;
bottom_size = 1;

bottom_height = board_height+side_padding+top_padding+lip_height;
bottom_width = side_padding*2 + board_width;

module bottom_outline() {
  offset(corner_radius, $fn=50)
  offset(-corner_radius*2, $fn=50)
  offset(corner_radius, $fn=50)
  square([bottom_width, bottom_height]);
}

usb_position = 32.23+8.25/2; // distance from side to inner side of usb connector + width of jack/2
//usb_position = 35;
usb_down = 9.3;
usb_size_x = 13;
usb_size_y = 8;
usb_radius = 2;

screw_head_diameter = 6;
screw_head_depth = 3;

module bottom_screw_hole() {
  cylinder(d=screw_diameter*1.1, bottom_thickness+1, $fn=50);
  cylinder(d=screw_head_diameter, bottom_thickness-front_thickness + screw_head_depth, $fn=50);
}

module bottom() {
  difference() {
    linear_extrude(bottom_thickness)
    bottom_outline();
    
    // slant
    translate([bottom_width, 0])
    rotate([0, 270, 0])
    linear_extrude(bottom_width)
    polygon([[0, 0], [0, bottom_height], [bottom_thickness-front_thickness, 0]]);
    
    // inner space    
    space_height = board_height + side_padding;
    translate([bottom_width-side_padding, side_padding, bottom_thickness])
    rotate([0, 270, 0])
    linear_extrude(board_width)
    #polygon([
      [1, 0], 
      [1, space_height], 
      [-usb_size_y/2 - usb_down, space_height],
      [-front_thickness+bottom_size, 0],
    ]);
    
    // usb port
    translate([usb_position-usb_size_x/2, bottom_height+1, bottom_thickness-usb_down-usb_size_y/2])
    rotate([90, 0])
    linear_extrude(bottom_height - board_height-side_padding*2+1)
    offset(usb_radius, $fn=50)
    offset(-usb_radius, $fn=50)
    square([usb_size_x, usb_size_y]);
    
    // screw holes
    translate([side_padding/2+screw_offset, side_padding/2+screw_offset]) {
      bottom_screw_hole();
      translate([0, board_height+side_padding-screw_offset*2]) bottom_screw_hole();
      
      translate([board_width + side_padding-screw_offset*2, 0]) {
        bottom_screw_hole();
        translate([0, board_height+side_padding-screw_offset*2]) bottom_screw_hole();
      }
    }
  }
}

top();
//translate([0, 0, -bottom_thickness]) 
bottom();



