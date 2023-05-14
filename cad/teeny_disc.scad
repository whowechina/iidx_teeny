#disc();

module disc(d=120,h=3,r=1.6) {
  difference() {
    minkowski() {
      cylinder(d=d-r,h=h-r,$fn=256);
      sphere(d=r,$fn=32);
    }
    hole([6,0]);
    hole([-6,0]);
    hole([0,6]);
    hole([0,-6]);
  }
}

module hole(pos) {
  translate([pos[0],pos[1], -1]) cylinder(d=3.2,h=14,$fn=64);
}
