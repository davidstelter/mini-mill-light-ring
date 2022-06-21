// borrowed from https://www.xarg.org/snippet/circular-sector-and-arcs-with-openscad/
// outerR: outer radius
// innerR: inner radius
// startAng: start angle
// stopAng: end angle
//
module arc(outerR, innerR, startAng, stopAng) {
  difference() {
    difference() {
      polygon([
		  [0,0],
		  [cos(startAng) * (outerR + 50), sin(startAng) * (outerR + 50)],
		  [cos(stopAng) * (outerR + 50), sin(stopAng) * (outerR + 50)]
	  ]);
      circle(r = innerR);
    }
    difference() {
      circle(r=outerR + 100);
      circle(r=outerR);
    }
  }
}
