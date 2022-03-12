include <arc.scad>

$fn=200;
sleeveDiam = 48;
sleeveHeight = 52;

lightOuterDiam = 80.75;
lightInnerDiam = 60;
lightHeight = 9;
lightZOffset = -(lightHeight/2 + 10);

ringOuterDiam = 85;
ringInnerDiam = 50;
ringHeight = 20;
topRecessDiam = 80;
ringZOffset = -ringHeight/2;

magnetDiam = 8;
magnetPathDiam = (topRecessDiam-magnetDiam)-1;
magnetHoleDepth=1;
magnetRemovalHoleDiam=2;

zThroughHoleLen = (ringHeight * 2) + 2;
zThroughHoleOff = -(zThroughHoleLen / 2);

module light_ring() {
	lightR=(lightOuterDiam - lightInnerDiam) / 4;
	translate([0,0,lightZOffset+lightR])

	difference() {

		rotate_extrude()
			translate([(lightInnerDiam/2) + lightR, 0, 0])
			scale([1,1.45])
			circle(r=lightR, $fn=50);
		translate([0,0,lightR])
			cube([lightOuterDiam+1,lightOuterDiam+1,lightR*2], center=true);
	}
}

module mounting_ring() {
	translate([0,0,ringZOffset])
	difference() {
		union() {
			cylinder(h=ringHeight, d=ringOuterDiam, center=true);
			translate([0,0,-ringZOffset])
				cylinder(h=2, d=topRecessDiam, center=true);
		}
		union() {
			cylinder(h=ringHeight+10, d=ringInnerDiam, center=true);

			translate([0,-50,-ringZOffset+.1])
			cylinder(h=2, d=35, center=true);

			translate([0,0, -ringHeight/2])
				cylinder(h=ringHeight, d=lightOuterDiam + 0.5, center=true);

			// light power lead hole
			translate([-37, 0, 0])
			cylinder(h=50, d=3, center=true);

			translate([0,0,2])
			linear_extrude(12) {
				arc(39, 29, 110, 190);
			}

			// magnet holes
			translate([0,0,-ringZOffset-1])
			linear_extrude(magnetHoleDepth+2)
			for (i = [-1: 1])
			rotate(i * 120) 
			translate([0, magnetPathDiam/2]) {
				circle(d = magnetDiam);
			}

			// magnet removal poke holes
			translate([0,0,zThroughHoleOff])
			linear_extrude(zThroughHoleLen)
			for (i = [-1: 1])
			rotate(i * 120) 
			translate([0, magnetPathDiam/2]) {
				circle(d = magnetRemovalHoleDiam);
			}
		}
	}
}

module sleeve() {
translate([0,0,-(sleeveHeight/2)+2])
	cylinder(h=sleeveHeight, d=sleeveDiam, center=true);
}

//color("silver") sleeve();

color("white") light_ring();

color("red") mounting_ring();
