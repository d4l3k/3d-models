
module base() {
translate([-207.25, -150, -24])
import("Deej_case_2.stl");
    
}

pcb_len = 36.15;

difference() {
    base();
 
translate([0, 40, 6.0])
cube([10, 10, 5], center=true); 
  
translate([0, 21, 5.3])
cube([18.2, pcb_len, 5], center=true);   
}

translate([0, 38.5-pcb_len, 4])
cube([10, 1, 4], center=true);   
translate([0, 38.75-pcb_len, 5.5])
cube([10, 1, 1], center=true);   
