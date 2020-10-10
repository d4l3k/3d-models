end_height = 1; // mm
end_width = 13.73;

//inner_width = 14.56;
inner_width = 15.54;
height = 30;
thickness = 2;

linear_extrude(5)
difference() {
  square([height+thickness+end_height, inner_width+thickness*2]);
  
  translate([end_height, thickness])
  square([height, inner_width]);
  
  translate([0, (inner_width-end_width)/2+thickness])
  square([height, end_width]);
}