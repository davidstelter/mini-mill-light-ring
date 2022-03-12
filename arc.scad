// borrowed from https://www.xarg.org/snippet/circular-sector-and-arcs-with-openscad/
// r1: outer radius
// r2: inner radius
// a1: start angle
// a2: end angle
//
module arc(r1, r2, a1, a2) {
  difference() {
    difference() {
      polygon([[0,0], [cos(a1) * (r1 + 50), sin(a1) * (r1 + 50)], [cos(a2) * (r1 + 50), sin(a2) * (r1 + 50)]]);
      circle(r = r2);
    }
    difference() {
      circle(r=r1 + 100);
      circle(r=r1);
    }
  }
}
