
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
    translate([42, 0, -0.4])
    cube([80, 2.8, 2.8], center=true);

    // taper
    //translate([1, 0, 0])
    //scale([2, 2])
    //rotate([0, -90, 0])
    //pyramid();
}

module receptacle064 () {
    // tab hole
    cube([10, 0.64, 0.64], center=true);

    // wire hole
    translate([-42, 0, 0.5])
    cube([80, 1.5, 2.2], center=true);

    // taper
    translate([1, 0, 0])
    scale([2, 1])
    rotate([0, -90, 0])
    pyramid();
}

module receptacles() {
    for (z = [0]) {
        for (y = [0, 1.8, 1.8*6, 1.8*7]) {
            translate([0, y, z])
            receptacle064();
        }
    }
    
        for (z = [-1.5]) {
        for (y = [0:1.8:14]) {
            translate([0, y, z])
            rotate([180, 0, 0])
            receptacle064();
        }
    }


}

module base () {
            translate([-14, 6.3, 1])
    cube([20, 4.2, 2], center=true);

}

difference() {
    translate([2, 6.3, -0.75])
    rotate([90, 0, 90])
    translate([-100, -100, 0])
    import("./c-4-2177370-3-d-3d.stl");

    
    
    receptacles();
    

}


