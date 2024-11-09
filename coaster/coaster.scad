height = 5;
depth = 1;
font_size = 13;
font_spacing = 18;

black = true;
person = "tristanr";

module hex() {
    //rotate([0, 0, 30])
    import("hexagon.svg", center=true);
}

module base() {
    difference() {
        linear_extrude(height, center=false)
        hex();
        
        translate([0, 0, height-depth])
        linear_extrude(depth, center=false)
        scale(0.88)
        hex();
        
        color();
    }
}

module mytext(message, size=font_size) {
    text(message, size=size, font="Freight:style=Sans Medium", halign="center", valign="center");
}

module color() {
    translate([0, 3, height-depth])
    linear_extrude(depth, center=false)
    scale(2.2)
    import("PyTorch_logo_icon.svg", center=true);
    
    linear_extrude(depth, center=false)
    rotate([0, 180, 0])
    {
        translate([0, font_spacing, 0])
        mytext("PyTorch");
    
        mytext("Distributed");
        
        
        translate([0, -font_spacing, 0])
        mytext(person);
    }
}

if (black) {
    base();
} else {
    color();
}

