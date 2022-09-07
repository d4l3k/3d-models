in = 25.4;

$fn = 200;

//x = 2.7745 * in;
x = 4.5935 * in;
y = 4.5320 * in;

lip_width = 1;
lip_border = 2.5;

border_width = 4 + lip_width;
border = 5;
top_thickness = 8;

pad_d = 4.7310 * in;
strut_width = 10;

difference() {
  cube([x+border*2, y+border+top_thickness, border_width]);
  
  translate([border, border, lip_width])
  cube([x, y, 10]);
  
  translate([border+lip_border, border+lip_border, -1])
  cube([x-lip_border*2, y-lip_border*2, 10]);
}

translate([x/2+border, y+border, pad_d/2])
rotate([-90, 0, 0])
cylinder(r=pad_d/2, h=top_thickness);

translate([0, y+border, 0])
cube([x+border*2, top_thickness, pad_d/2]);

for (i = [0, x+border]) {
  support_height = y*2/3;
  translate([i, y-support_height+border, 0])
  rotate([0, 0, 0])
  union () {
    translate([(border-2)/2, 0, 0])
    prism(2, support_height, pad_d/2);

    difference () {
      prism(border, support_height, pad_d/2);
      
      translate([-1, strut_width, 0])
      prism(border*2, support_height-strut_width, pad_d/2-strut_width);
    }
  }
}

module prism(l, w, h) {
  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
}
