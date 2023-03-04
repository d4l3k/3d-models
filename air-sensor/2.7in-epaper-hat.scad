pcb_length = 85.25;
pcb_height = 56.06;
pcb_width = 1.65;

component_depth = 2.78; // component height on back side
component_margin_top = 12.25;
component_margin_left = 6;
component_length = 63;
component_height = 16;

pcb_hole = 3;
pcb_hole_margin = 2.06;
pcb_near_hole = 2.50;
pcb_far_hole = 60.37;

button_length = 6.27;
button_height = 3.66;
button_depth = 2.60;
button_spacing = 7.26;
button_margin_top = 3.9;
button_margin_right = 1.6;

connector_length = 20.15;
connector_height = 8.22;
connector_depth = 5.87;
connector_margin_top = 17.00;

screen_inner_width = 61.45;
screen_inner_height = 42.29;
screen_depth = 1.11;

screen_inner_left_margin = 8.80;
screen_inner_top_margin = 9.38;


module eink() {
  $fn = 100;

  module pcb_cut() {
    translate([pcb_hole/2, pcb_hole/2])
      cylinder(h=100, d=pcb_hole, center=true);
  }

  difference() {
    cube([pcb_length, pcb_height, pcb_width]);
    
    for (margin = [pcb_near_hole, pcb_far_hole]) {
      translate([margin, pcb_hole_margin, 0])
      pcb_cut();
    }
    
    translate([pcb_near_hole, pcb_height-pcb_hole_margin-pcb_hole])
    pcb_cut();
  }

  translate([screen_inner_left_margin, screen_inner_top_margin, -screen_depth])
  cube([screen_inner_width, screen_inner_height, screen_depth]);

  translate([pcb_length-button_margin_right-button_height, button_margin_top, -button_depth])
  for (i = [0, 1, 2, 3]) {
    translate([0, (button_length+button_spacing)*i, 0])
    cube([button_height, button_length, button_depth]);
  }

  translate([0, connector_margin_top, pcb_width])
  cube([connector_height, connector_length, connector_depth]);
  
  translate([pcb_length-component_length-component_margin_left, component_margin_top, pcb_width])
  cube([component_length, component_height, component_depth]);
}

//eink();