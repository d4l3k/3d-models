
$fn = 100;

gap = 9; // mm

fudge =  0.1; // mm

command_strip_height = 1;
command_strip_width = 20;
command_strip_length = 75;

magnet_height = 10.0/6; // mm
magnet_r = 10.0/2 + fudge; // mm

module magnet() {
    cylinder(h=magnet_height, r=magnet_r);
}


module base() {
    height = gap / 2 - command_strip_height;
    cube([
        command_strip_length,
        command_strip_width,
        height,
    ]);
}

difference() {
base();

for (i = [0, 1, 2]) {
    
    translate([(i+1) * command_strip_length/4, command_strip_width/2, 0])
    magnet();
}
}