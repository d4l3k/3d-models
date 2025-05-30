height = 3;
depth = 2;
bottom_depth = 2;
font_size = 13;
font_spacing = 18;
logo_offset = 9.4;

pin_size = 2.5;

black = true;
person = "a";

$fn = 80;
name_size = len(person) <= 8 ? font_size : font_size*8/len(person);


module hex() {
    //rotate([0, 0, 30])
    translate([0, logo_offset-0.8])
    scale(3)
    import("PyTorch_siloutte_round.svg", center=true);
}

module base() {
    translate([0, 0, height])
    cylinder(h=depth, r=29.8);
    
    difference() {
        linear_extrude(height, center=false)
        hex();
        
        
        color();
        
        translate([0, -40, 0])
        cylinder(h=height, r=pin_size);
    }
}

module mytext(message, size=font_size) {
    translate([0, -size*0.4, 0])
    text(message, size=size, font="Freight:style=Sans Medium", halign="center");
}

module color() {
    translate([0, logo_offset, height])
    linear_extrude(depth, center=false)
    scale(2.8)
    import("PyTorch_logo_icon.svg", center=true);
    
    linear_extrude(bottom_depth, center=false)
    translate([0, -4, 0])
    rotate([0, 180, 0])
    {
        translate([0, 45, 0])
        scale(0.8)
        import("PyTorch_logo_icon.svg", center=true);
        
        translate([0, font_spacing, 0])
        mytext("PyTorch");
    
        mytext("Distributed");
        
        
        translate([0, -font_spacing, 0])
        mytext(person, size=name_size);
    }
}

module stand() {
    stand_width = 30;
    stand_angle = 60;
    stand_length = 50;
    difference() {
        translate([0, -48, height/2])
        cube([stand_width, 5, height], center=true);
        base();
    }
    translate([0, -40.5, -height/2])
        cube([stand_width, 20, height], center=true);
    
    translate([0, -40, 0])
        cylinder(h=height, r=pin_size-0.5);
    
    translate([0, -50.5, height])
    rotate([-stand_angle])
        translate([0, stand_length/2, -height/2])
        cube([stand_width, stand_length, height], center=true);
}


//stand();


if (black) {
    base();
} else {
    color();
}


