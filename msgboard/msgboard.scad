
board_thickness = 2;

in = 25.4;
board_height = 1.1*in;
board_length = 1.6*in;

display_height = 16;
display_thickness = 8;
    
margin = 10;
wall_thickness = 2;
screen_length = board_length*4;
total_length = screen_length+2*margin;

body_size = 40;
cut_pos = 12;
screen_pos = 21;
screw_hole = 2.8;

c3_x = 21;
c3_y = 17.8;
c3_z = 1.57;
    
screw_box_size = 10;


module display() {
    
    translate([(board_height-display_height)/2,0,board_thickness])
            cube([display_height, 40, display_thickness]);
    
    difference() {
        cube([board_height, board_length, board_thickness]);
        
        display_holes(4);
    }

}

module display_holes(d) {
    for (y = [0.1*in, 1.5*in]){
        for (x = [0.1*in, 1.0*in]) {
            translate([x, y, 0])
            cylinder(h=6, d=d, $fn=10);
        }
    }
}

module cut_box(x, y, z, cut) {
    difference() {
        cube([x, y, z]);
        
        translate([x-cut, 0, z-cut])
        rotate([0, 45, 0])
        translate([-x, -10, 0])
        cube([x*2, y+20, z]);
    }
}
module body() {

    difference () {
        cut_box(body_size,total_length,body_size, cut_pos);
        
        translate([-wall_thickness, wall_thickness, wall_thickness])
        cut_box(
        body_size,
        total_length-wall_thickness*2,
        body_size-wall_thickness*2,
        cut_pos-wall_thickness+8/sqrt(2));
        
        translate([body_size-cut_pos, margin, body_size-cut_pos])
        rotate([0, 45, 0])
        translate([-display_height/2, 0, -display_thickness-1])
        cube([display_height, screen_length, 2+display_thickness]);
        
        translate_screen() display_holes(screw_hole);
    }

    for (y = [0, total_length-screw_box_size]) {
        for (z = [0, body_size-screw_box_size]) {
            translate([0, y, z])
            difference() {
                cube([screw_box_size, screw_box_size, screw_box_size]);
                
                translate([0, screw_box_size/2, screw_box_size/2])
                rotate([0, 90, 0])
                #cylinder(h=screw_box_size, d=screw_hole, $fn=10, center=false);
            }
        }
    }

    translate([0, total_length/2-c3_x/2, 0])
    difference () {
        cube([c3_x+wall_thickness, c3_y+wall_thickness*2, wall_thickness*2+c3_z]);
        
        translate([0, wall_thickness, wall_thickness])
        cube([c3_x, c3_y, c3_z]);
        
        translate([0, wall_thickness*1.5, wall_thickness])
        cube([c3_x+10, c3_y-wall_thickness, 10]);
        
        translate([wall_thickness*3, -1, wall_thickness])
        cube([c3_x-wall_thickness*4, c3_y+10, 10]);
    }
}

module translate_screen() {
    translate([screen_pos, margin, screen_pos])
    rotate([0, 45, 0])
    translate([-board_height/2, 0, 0])
    
    for (i  = [0, 1, 2, 3]) {
        translate([0, board_length*i, 0])
        children();
    }
}

module displays() {
    translate_screen()
    display();
}

module lid() {
    difference() {
        translate([-wall_thickness, 0, 0])
        cube([wall_thickness, total_length, body_size]);
        
        for (y = [0, total_length-screw_box_size]) {
            for (z = [0, body_size-screw_box_size]) {
                translate([0, y, z])
                    translate([-wall_thickness, screw_box_size/2, screw_box_size/2])
                    rotate([0, 90, 0])
                    #cylinder(h=screw_box_size, d=3, $fn=10, center=false);
            }
        }
        
        translate([0, total_length/2, 5])
        cube([10, 10, 4], center=true);
    }
}

//body();
lid();

//displays();

//translate([-50, 0, 0]) display();