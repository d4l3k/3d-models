
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

usb_width = 15;
usb_position = 0;
row_spacing = 19;

module hole() {
  circle(r=hole_size, $fs=0.1);
}

module roundsquare(width, height, radius=0) {
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


module plate(extra=0) {
  difference () {
    base(extra);
    
    layout();
  }
}

//plate();

module key(width=16.05) {
  union() {
    translate([0, 9]) roundsquare(width, 5, 1);
    translate([0, 0]) roundsquare(width, 5, 1);

    translate([1, 0])
    square([width-2, 14]);
  }
}

module row(keys) {
  for ( i = [0 : keys-1] ) {
    translate([key_spacing * i, 0]) key();
  }
}

module row2() {
  translate([7.1, 0]) union() {
    key();
    translate([key_width + 10.10, 0]) 
    union() {
      row(9);
      
      translate([key_spacing * 8 + key_width + 5.4, 0])
      key();
    }
  }
}

module row3() {
  key();
  translate([key_width + 5.37, 0]) 
  union() {
    key();
    translate([key_width + 5.37, 0])
    union() {
      row(8);
      translate([key_spacing * 7 + key_width + 10.18, 0])
      key();
    }
  }
}

module row4() {
  left_width = 18.37;
  union() {
    key(left_width);
    
    translate([left_width + 0.66, 0])
    union() {
      key();
      
      translate([29, 13]) roundsquare(10, 2, 1);

      square_width = 41.23;
      translate([1, 0])
      union() {
        roundsquare(square_width, 14, 1);
        
        translate([square_width+5.3, 0])
        union() {
          translate([0, 13]) 
          union() {
            roundsquare(6, 2, 1);
            
            translate([10, 0]) roundsquare(6, 2, 1);
            translate([24, 0]) roundsquare(6, 2, 1);
            translate([33.65, 0]) roundsquare(6, 2, 1);
            translate([47.84, 0]) roundsquare(6, 2, 1);
            translate([57.28, 0]) roundsquare(6, 2, 1);
            translate([71.65, 0]) roundsquare(6, 2, 1);
            translate([81.19, 0]) roundsquare(10.5, 2, 1);
          }
          
          space_width = 134.16;
          roundsquare(space_width, 14, 1);
          translate([space_width - key_width + 1, 0])
          union() {
            key();
            translate([key_width + 3.05, 0])
            key(left_width);
          }
        }
      }
    }
  }
  
}

module layout() {
  translate([0, row_spacing * 3]) row(12);
  translate([0, row_spacing * 2]) row2();
  translate([0, row_spacing * 1]) row3();
  translate([0, row_spacing * 0]) row4();
}

tab_width = 20;
notch_width = 2.25;
module tab() {
  translate([0, -3])
  difference() {
    roundsquare(tab_width, 6, 3);
    
    translate([(tab_width-notch_width)/2, 3])
    roundsquare(notch_width, 5, notch_width/2);
  }
}

board_height = 76;
board_width = 114;
lip_size = 50;;

module outline () {
  union() {
    square([board_width+10,board_height+10]);
    translate([0, 80])
    square([lip_size,15]);
    translate([lip_size, 80])
    polygon([[0,0], [0, 15], [15, 0]]);
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

translate([10, board_height+9, 9])
linear_extrude(height=5)
scale(0.8)
text("jinboat", font="Noto Sans:style=Medium");
}

module inner() {
   translate([5, 5])
  offset(1, $fn=50)
  offset(-1, $fn=50)
  square([board_width, board_height]);
}

module logoed() {
//edged();
difference() {
edged();
inner();
  logo();
}
}

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





module layoutfile() {
    import(file="jinboat_keys.dxf");
}

module keyboard() {   
  translate([5-0.1, 5-0.3, 0.5])
  linear_extrude(height=1)
 layoutfile();
}  

//keyboard();
//layoutfile();
