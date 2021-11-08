

translate([0, 20, -3])
import("leviton2gang.amf", convexity=3);


difference() {
  import("POINT_HOLDER.stl", convexity=3);

translate([0, 8, 0])
cube([100, 80, 10], center=true);
}