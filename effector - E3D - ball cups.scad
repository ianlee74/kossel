include <configuration.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
ball_dia = 12.7;

module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true, $fn=100);
      for (a = [60:120:359]) rotate([0, 0, a]) {
			rotate([0, 0, 30]) 
			translate([offset-2, 0, 0])
	  			#cube([28, 30, height], center=true);
      }
    }

      for (a = [60:120:359]) rotate([0, 0, a]) {
			for (s = [-1, 1]) scale([s, 1, 1]) {
	  			translate([0, offset, 0]) 
				difference() {							
	    			translate([separation/2, 0, 5]) rotate([0, 90, 0])
					sphere(ball_dia/2, $fn=200);
		 		}
			}
      }


    translate([0, 0, push_fit_height-height/2])
      cylinder(r=hotend_radius, h=height, $fn=100);
    translate([0, 0, -6]) //# import("m5_internal.stl");
		cylinder(r=8.5, h=height, $fn=100);
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
		cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=100);
    }
  }
}

translate([0, 0, height/2]) effector();