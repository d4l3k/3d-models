width = 125.5+0.5;
support_size = 8;
edge_height = 10;
lip_depth = 16.81;
lip_width = 5.51+0.5;
bar_diameter = 29.1+0.5;
bar_distance = 53.5;
bar_down_from_lip = 51;
extrude_size = 10;

zip_tie_height = 1.28+0.5;
zip_tie_width = 4.67+0.5;

module pattern() {
translate([-support_size*1.5, -support_size-edge_height])
difference() {
  square([width+support_size*2, edge_height+support_size]);
  translate([support_size, 0])
    square([width, edge_height]);
}

translate([width-support_size*1.5, 0])
square([support_size, lip_depth]);

translate([bar_distance-support_size, 0])
{
square([support_size, lip_depth*0.5]);
translate([support_size+lip_width, 0])
square([support_size, lip_depth]);
}


  translate([-support_size/2, 0])
  square([support_size, bar_down_from_lip]);

  translate([0, bar_diameter/2+bar_down_from_lip])
  difference() {
    circle(d=bar_diameter+support_size*1.5);
    circle(d=bar_diameter);
    translate([-(bar_diameter+support_size*2)/2, 0])
      square(bar_diameter+support_size*2);
}
}

module zip_tie() {
  translate([0,0,extrude_size/2])
  cube([1000, zip_tie_height, zip_tie_width], center=true);
}


difference() {
linear_extrude(extrude_size)
pattern();
  zip_tie();
  translate([0, bar_down_from_lip-support_size/1.5])
  zip_tie();

}