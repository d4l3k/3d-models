inner_diameter = 101;
outer_diameter = 150;
hole_diameter = 109;
thickness = 2;
tube_height = 30;

strut_height = 40;
strut_thickness_top = 1;
strut_thickness_bottom = 3;
strut_skew = hole_diameter-inner_diameter-strut_thickness_top;
strut_width = 20;
num_bars = 7;

$fn = 200;

module outer() {
  cylinder(thickness, d=outer_diameter);
  cylinder(tube_height, d=inner_diameter);
}


difference() {
  outer();
  translate([0,0,-thickness])
cylinder(tube_height+thickness*2, d=inner_diameter-thickness*2);
}


module strut() {
  translate([-strut_width/2,-strut_skew-strut_thickness_top, thickness])
  rotate([90, 0, 90])
  linear_extrude(strut_width)
polygon([
  [0,0], 
  [strut_thickness_bottom,0], 
  [strut_thickness_top+strut_skew, strut_height], 
  [strut_skew, strut_height]]);
}

module perp_struts() {
translate([0, -inner_diameter/2 ])
strut();

translate([0, inner_diameter/2])
rotate([0, 0, 180])
strut();
}

perp_struts();
rotate([0,0,90])
perp_struts();


module bar() {
translate([0,0,thickness/2])
//rotate([90, 0, 0]) cylinder(inner_diameter+thickness, d=2*thickness, center=true);
rotate([0, 0, 90]) cube([inner_diameter+thickness, 2*thickness, thickness], center=true);
}

rotate([0, 0, 90])
bar();

bar_spacing = inner_diameter/(num_bars+1);

for(i=[-inner_diameter/2 : bar_spacing : inner_diameter/2]) {
  translate([i, 0, 0])
  bar();
}