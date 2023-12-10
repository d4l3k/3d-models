
// 6098-5604.stp
// 6098-5594.stp





module pyramid() {
polyhedron(
  points=[ [1,1,0],[1,-1,0],[-1,-1,0],[-1,1,0], // the four points at base
           [0,0,1]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}


module receptacle15 () {
    // tab hole
    cube([10, 1.5, 0.64], center=true);

    // wire hole
    translate([-12, 0, -0.4])
    cube([20, 2.8, 2.8], center=true);

    // taper
    translate([1, 0, 0])
    scale([2, 2])
    rotate([0, -90, 0])
    pyramid();
}

module receptacle064 () {
    // tab hole
    cube([10, 0.64, 0.64], center=true);

    // wire hole
    translate([-12, 0, -0.15])
    cube([20, 1.8, 2.7], center=true);

    // taper
    translate([1, 0, 0])
    scale([2, 1])
    rotate([0, -90, 0])
    pyramid();
}

module receptacles() {
    
    for (z = [0, -3.2]) {
        for (y = [0, 3.2, 20.1, 23.3]) {
            translate([0, y, z])
            receptacle15();
        }
    }
    
    for (z = [-0.3]) {
        for (y = [6.15, 8.35, 10.55, 12.75, 14.95, 17.15]) {
            translate([0, y, z])
            receptacle064();
        }
    }
    
        for (z = [-3.25]) {
        for (y = [6.15,  10.55, 12.75,  17.15]) {
            translate([0, y, z])
            receptacle064();
        }
    }


}

difference() {
    //translate([-106.1, -91.6, -7.9])
    import("./6098-5594.stl");
    receptacles();

}


