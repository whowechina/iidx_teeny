difference() {
  union() {
    cylinder(d=98,h=0.8,$fn=200);
    cylinder(d=97,h=6,$fn=200);
    translate([0,0,5.2]) cylinder(d=97.8,h=0.98,$fn=200);
  }
  translate([0,0,-1]) cylinder(d=95.6,h=20,$fn=200);
  translate([-3,40,1]) #cube([6,10,10]);
}

difference()
{
  union() {
    for (i=[30:60:360]) {
      rotate([0,0,i]) translate([0,-1.5,0]) cube([48,3,1.5]);
    }
  }
  translate([0,0,-1]) cylinder(d=84,h=4,$fn=200);
}

