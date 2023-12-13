
$fn=100;

module base() {
    translate([55.0347-2.5, -52.8066+110-2.5, 23])
    rotate([180, 0, 0])
    import("stock_orin_base.stl");   
    
   extension(); 
}

module extension() {
    
    start = 18;
    height = pcb_height-start;
    difference() {
        translate([-2.5, -2.5, start])
        cube([110, 110, height]);
        
                translate([0, 0, start-1])
        cube([105, 105, height+2]);

    }
}



difference() {
base();


for (x = [6, 85]) {
    for (y = [9.5, 95.5]) {
        translate([x, y, 8.5+3])
        #cube([6, 6, 17], center=true);
    }
}


translate([0, 0, 20.5])
cube([105, 105, 3]);

translate([76, 90, 11])
#cube([30, 2, 10]);

top_pcb();
}

    pcb_height = 25.37;


module top_pcb() {
    
    // pcb
    translate([0, 0, pcb_height])
    cube([105, 105, 1.6]);
    
    // power connector
    connector_width = 9.93;
    connector_height = 10.68;
    translate([105-5-connector_width, -5, pcb_height-connector_height])
    cube([connector_width, connector_width, connector_height]);
    
    // cameras
    spacing = 17.23;
    for (x = [22.36, 22.36+spacing, 22.36+spacing*2, 22.36+spacing*3]) {
        for (y = [-5, 100]) {
            translate([x, y, 21.30]) 
            cube([8.58, 8.58, 7.83]);
        }
    }
    for (y = [22.36, 22.36+spacing, 22.36+spacing*2, 22.36+spacing*3]) {
        for (x = [-5, 100]) {
            translate([x, y, 21.30]) 
            cube([8.58, 8.58, 7.83]);
        }
    }
}

module peg() {
    base = 19;
    translate([0, 0, base])
    difference () {
        translate([0,0,0]){
            cylinder(h=2,d=8.5);
            cylinder(h=pcb_height-base,d=4.7);
        }
        cylinder(h=10, d=2.7);
    }
}

module pegs() {
    for (x=[6, 85]) {
        for (y = [6.5, 98.5]) {
            translate([x, y, 0])
            peg();
        }
    }
}

pegs();

//top_pcb();