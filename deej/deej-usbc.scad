
module base() {
translate([-207.25, -150, -24])
import("Deej_case_2.stl");
    
}


difference() {
    base();
 
translate([0, 40, 6.0])
cube([10, 10, 5], center=true); 
  
translate([0, 21, 5.3])
cube([18.2, 36, 5], center=true);   
}

translate([0, 2.5, 4])
#cube([10, 1, 4], center=true);   
translate([0, 3, 5.5])
#cube([10, 1, 1], center=true);   
