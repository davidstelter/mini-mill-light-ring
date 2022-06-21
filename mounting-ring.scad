include <arc.scad>
include <dc_jack.scad>

$fn = 200;

debug = false;
mainColor = "red";

lightTabHeight = 3.45;
lightTabWidth = 6;
lightTabThick = 1.4;
lightLatchThick = 1;

showSpindle = true;
spindleDiam = 40;
spindleHeight = 52;

showDcJack = true;

bearingRecess = true;

showLight = true;
lightOuterDiam = 82.75;
lightInnerDiam = 68;
lightHeight = 7.4;
subtractLightTabRecess = true;

showMountingRing = true;
showOuterShroud = true;
shroudHeight = 20;
ringOuterAddDiam = 2;
ringOuterDiam = lightOuterDiam + ringOuterAddDiam;
ringInnerDiam = spindleDiam + 2;
ringHeight = 24;
topRecessDiam = 80;
ringZOffset = -ringHeight/2;

lightZOffset = -(lightHeight + ringHeight)/2;

magnetDiam = 8;
magnetHeight = 3;
magnetWiggle = 0.1;
magnetPathDiam = (topRecessDiam-magnetDiam)-3.2;
magnetHoleDepth = 2;
magnetRemovalHoleDiam = 2;

zThroughHoleLen = (ringHeight * 2) + 2;
zThroughHoleOff = -(zThroughHoleLen / 2);

module light_ring() {
	light_ring_ring();
	light_ring_tabs();
	if (debug) {
		color("pink") light_ring_tab_recess();
	}
}

module light_ring_ring() {
	lightR=(lightOuterDiam - lightInnerDiam) / 4;

	translate([0,0,lightZOffset+lightR])
	difference() {
		union() {
			rotate_extrude()
				translate([(lightInnerDiam/2) + lightR, 0, 0])
				scale([1,1.45])
				circle(r=lightR, $fn=200);
		}

		translate([0,0,lightR])
			cube([lightOuterDiam+1,lightOuterDiam+1,lightR*2], center=true);
	}
}

module light_ring_tabs() {
	lightR=(lightOuterDiam - lightInnerDiam) / 4;

	translate([0,0,lightZOffset - (lightR * 1.22)])
	intersection() {
		rotate_extrude()
			translate([(lightInnerDiam/2), 8])
			polygon([
				[0,0],
				[lightTabThick,0],
				[lightTabThick,lightTabHeight],
				[0,lightTabHeight],
				[-1.3,lightTabHeight-1],
				[0,lightTabHeight-1]
			]);

		rotate([0,0,90])
		for (i = [-1 : 1]) {
			rotate([0,0,120*i])
			translate([(lightInnerDiam/2) - lightTabThick, 0, 8])
				cube([20,lightTabWidth,20], center=true);
		}
	}
}

module light_ring_tab_recess() {
	lightR=(lightOuterDiam - lightInnerDiam) / 4;
	wiggle=0.1;
	wiggleScaling=[1 + wiggle, 1 + wiggle, 1 + wiggle];
	recessThick = lightTabThick + 1;
	recessHeight = lightTabHeight + wiggle;
	recessInner = 0 - wiggle;
	recessWidth = lightTabWidth + 2 * wiggle;
	toothFlatY = recessHeight - (1 + wiggle);
	pokeHoleD = 3.5;
	pokeHoleH = 20;
	recessZOffset = lightZOffset - (lightR * 1.22);
	
	rotate([0,0,90]) {
		translate([0,0,recessZOffset])
		intersection() {
			rotate_extrude()
				translate([(lightInnerDiam/2), 8])
				polygon([
					[recessInner, 0],
					[recessThick, 0],
					[recessThick, recessHeight],
					[recessInner, recessHeight],
					[-(1.3 + wiggle), toothFlatY],
					[recessInner, toothFlatY]
				]);

			for (i = [-1 : 1]) {
				rotate([0,0,120*i]) {
					translate([(lightInnerDiam/2) - lightTabThick, 0, 8]) {
						cube([20,recessWidth,20], center=true);

						cylinder(d=pokeHoleD, h=20, center=true);
					}
				}
			}
		}

		//translate([0,0,recessZOffset+8+toothFlatY])
		//#cube([100,100,0.001], center=true);

		for (i = [-1 : 1]) {
			rotate([0,0,120*i]) {
				translate([
					(lightInnerDiam/2),
					0,
					recessZOffset+8+toothFlatY + (pokeHoleH/2)
				]) {
					cylinder(d=pokeHoleD, h=pokeHoleH, center=true);
				}
			}
		}
	}
}

module outer_shroud() {
	lipH = 2;
	lipS = 6;
	dcJackCutoutW = 10.25;
	lipInnerD = ringOuterDiam - lipS;
	shroudD = ringOuterDiam + 4;
	shroudZOff = (ringHeight-shroudHeight)/2;

	translate([0,0,ringZOffset])
	difference() {
		union() { // positive
		translate([0,0,shroudZOff])
			color("green") cylinder(h=shroudHeight, d=shroudD, center=true);
		}
		union() { // negative
			cylinder(h=ringHeight+10, d=ringOuterDiam-0.5, center=true);

			// bearing recess
			if (bearingRecess) {
				translate([0,-50,-ringZOffset + 0.1]) {
					cylinder(h=2, d=35, center=true);
					cylinder(h=8, d=25, center=true);
				}
			}

			/* dc_jack_cutout(); */
			rotate([0,0,90])
			translate([0,-ringOuterDiam/2,5])
			rotate([90,0,0]) {
				cylinder(h=20, d=dcJackCutoutW, center=true);
				translate([0,dcJackCutoutW/2,0])
					cube([dcJackCutoutW,dcJackCutoutW,dcJackCutoutW], center=true);
			}

			//translate([0,0,shroudHeight*0.75]) cylinder(h=20,d=shroudD + 1, center=true);
		}
	}

	// lower lip
	translate([0,0,ringZOffset])
	difference() {
		union() { // positive
		translate([0,0,-(shroudHeight-lipH)/2])//-(shroudZOff-lipH)/2])
			color("orange") cylinder(h=lipH, d=shroudD, center=true);
		}
		union() { // negative
			cylinder(h=ringHeight+10, d=lipInnerD , center=true);
		}
	}
}

module dc_jack_cutout() {
	rotate([0,0,90])
	translate([0,-ringOuterDiam/2,5])
	rotate([90,0,0])
	intersection() {
		cylinder(h=20, d=7.8, center=true);
		cube([8,6.7,20], center=true);
	}
}

module mounting_ring(shroudHeight=10) {
	translate([0,0,ringZOffset])
	difference() {
		union() { // positive
			cylinder(h=ringHeight, d=ringOuterDiam, center=true);
			translate([0,0,-ringZOffset])
				cylinder(h=2, d=topRecessDiam, center=true);
		}
		union() { // negative
			cylinder(h=ringHeight+10, d=ringInnerDiam, center=true);

			// bearing recess
			if (bearingRecess) {
				translate([0,-50,-ringZOffset + 0.1]) {
					cylinder(h=2, d=35, center=true);
					cylinder(h=8, d=25, center=true);
				}
			}

			// light shroud & cutout for light
			translate([0,0, -ringHeight/2]) {
				/* cylinder(h=ringHeight, d=(shroudHeight <=0 ? ringOuterDiam + 1 : lightOuterDiam + 0.5), center=true); */
				cylinder(h=ringHeight, d=ringOuterDiam + 1, center=true);

				//if (shroudHeight > 0) {
				//	translate([0,0, -shroudHeight])
				//	cylinder(h=ringHeight, d=ringOuterDiam + 1, center=true);
				//}
			}

			dc_jack_cutout();

			// toggle switch
			rotate([0,0,135])
			translate([0,-ringOuterDiam/2,5])
			rotate([90,0,0])
				cylinder(h=20, d=6.4, center=true);

			// light power lead hole 1
			translate([-37, 0, 0])
			cylinder(h=50, d=3, center=true);

			// light power lead hole 2
			rotate([0,0,-24])
			translate([-37, 0, 0])
			cylinder(h=50, d=3, center=true);

			// wiring & electronics recesses
			translate([0,0,1])
			linear_extrude(24) {
				arc(39, 26, 70, -10);
				arc(39, 26, 110, 190);
			}

			// wire channel
			translate([0,0,6])
			rotate([0,0,64])
			rotate_extrude(angle=48) {
				translate([29,0])
				circle(d=6);
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

			if (subtractLightTabRecess) {
				translate([0,0,-ringZOffset])
					light_ring_tab_recess();
			}
		}
	}
}

module spindle() {
// R8 dimensions are imperial, sorry
taperHeight=(15/16)*25.4;
r8TaperD=1.25 * 25.4;
r8InnerD=0.949 * 25.4;

	difference() {
		union() {
			cylinder(h=spindleHeight, d=spindleDiam, center=true);
		}
		union() {
			cylinder(h=spindleHeight+2, d=r8InnerD, center=true);
			translate([0,0,-((taperHeight/2) + 3)])
				cylinder(d1=r8TaperD, d2=r8InnerD, h=taperHeight, center=true);
		}
	}
}

if (showSpindle) {
	translate([0,0,-(spindleHeight/2)+2])
	color("silver")
		spindle();
}

if (showLight) {
		light_ring();
}

if (showMountingRing) {
	color(mainColor)
		mounting_ring(shroudHeight);
}

if (showOuterShroud) {
	outer_shroud();
}

if (showDcJack) {
	translate([ringOuterDiam/2,0,-6])
	rotate([0,90,0])
	dc_jack();
}
