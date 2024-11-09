// Any-size Hose Adapter
// Copyright Chris Cogdon 2023
// Licence: CC BY-SA 4.0
// Full licence: https://creativecommons.org/licenses/by-sa/4.0/legalcode
// pipe 17.9mm

larger_OD = 80;
larger_length = 10;
smaller_OD = 16;
smaller_length = 20;
transition_length = 50;
thickness = 1.6;

// Dummy code to separate parameterized values.
module separator () {}

// Smoothness of curves. Larger values will cause larger rendering times. 200 is already
// pretty big.
$fn=200;
// A very small value to make differences appear correctly in a preview
epsilon=0.01;

module larger_segment() {
    linear_extrude(height=larger_length)
        difference() {
            circle(d=larger_OD);
            circle(d=larger_OD-thickness*2);
        }
}

module transition_segment() {
    difference(){
        linear_extrude(height=transition_length, scale=smaller_OD/larger_OD)
            circle(d=larger_OD);
        translate([0, 0, -epsilon])
            linear_extrude(height=transition_length+epsilon*2, 
                    scale=(smaller_OD-thickness*2)/(larger_OD-thickness*2))
                circle(d=larger_OD-thickness*2);
    }
}

module smaller_segment() {
    linear_extrude(height=smaller_length)
        difference() {
            circle(d=smaller_OD);
            circle(d=smaller_OD-thickness*2);
        }
    }

larger_segment();
translate([0, 0, larger_length]) transition_segment();
translate([0, 0, larger_length + transition_length]) smaller_segment();
