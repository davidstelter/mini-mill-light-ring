// 2.1mm and 2.5mm barrel sizes
// 14mm inner height
// 18.5mm overall length
// 10.4-10.5 outer diam
// insulated
// largest bushing height 3.28
module dc_jack(pinSize=2.1) {
	translate([0,0, -8.2 / 2])
	color("silver") {
		cylinder(h=8, d=pinSize, center=true);
		translate([0,0,4])
		
		sphere(d=pinSize);
	}

	translate([0,0,-8]) {
		translate([0,2.5,-5.5])
		solder_tab(5.5);

		translate([0,-2.5,-3.5])
		solder_tab(3.5);
	}

	difference() {
		union() {
			translate([0,0,3.25 / 2])
			color("grey")
				cylinder(h=3.25, d=10.5, center=true);

			translate([0,0, 4.1 / 2])
			color("silver")
				cylinder(h=4.1, d=8.85, center=true);

			translate([0,0,-2])
			color("grey")
			intersection() {
				// threaded section
				cylinder(h=12, d=7.7, center=true);
				// flats
				cube(size=[6.75,8,12], center=true);
			}
		}

		union() {
			translate([0,0,4])
				cylinder(h=18, d=5.5, center=true);

			// conic insertion relief
			translate([0,0,3.5])
				cylinder(d1=5, d2=7, h=1.5, center=true);
		}
	}
}

module solder_tab(length, width=2.25, holeDiam=1, thickness=0.4) {
	rotate([90,0,0])
	linear_extrude(thickness) {
		difference() {
			union() {
				circle(d=width);
				translate([0, length/2])
					square(size=[width, length], center=true);
			}
			circle(d=holeDiam);
		}
	}
}
