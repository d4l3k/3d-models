wheel_width = 17.60;

wheel_lip_width = 11.74;
wheel_inner_diameter = 13.06;
wheel_lip_diameter = 14.90;

wheel_outer_diameter = 17.89;
wheel_outer_lip_diameter = 23;
wheel_track_width = 9.15;


clip_width = 9.69; // width at base of clip
base_width = 3.3;

thickness = 4;
tol = 0.3;


linear_extrude(thickness)
for (i = [0, 180]) {
  
rotate([i])
polygon(points=[
  [0,0],
  [0,wheel_inner_diameter/2-tol],
  [base_width+wheel_lip_width+thickness+tol, wheel_inner_diameter/2],
  [base_width+wheel_lip_width+thickness+tol, wheel_lip_diameter/2+tol],
    [base_width+wheel_lip_width+thickness*2+tol, wheel_lip_diameter/2],

  [base_width+wheel_lip_width+thickness*3+tol, clip_width/2],
  [thickness, clip_width/2],
  [thickness, 0],
]);
  
}