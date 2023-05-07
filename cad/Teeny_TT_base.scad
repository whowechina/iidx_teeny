h1=6; // base
h2=14; // top
h3=10.5; // bed
h4=5.3; // bearing
h5=3; // pcb top

led_w=10;

led_h=4;

// 150 disc
disc_d=100;
d1=115; // lower outer
d2=105; // upper outer
d3=102; // disc area
led=96; // led ring

d4=58.2; // bearing
d5=28; // pcb

pcb_h=1.3;
d6=75;

$fn=64;

body();
//hinge();
//%disc();
%nsk6804();

module body() {
  difference() {
    color("gray") {
      hull() {
        cylinder(d=d1, h=h1, $fn=256);
        cylinder(d=d2, h=h2, $fn=256);
      }
      translate([58,0,0]) rcube(34,64,6.4,5);
    }

    color("gray") translate([0, 0, h3]) cylinder(d=d3, h=90, $fn=256);
    color("gold") translate([0, 0, h4]) cylinder(d=d4, h=90, $fn=128);
    color("gray") translate([0, 0, h5]) cylinder(d=d5, h=90);
    
    color("green") translate([0,0, 3]) difference() {
      cylinder(d=led,h=90,$fn=128);
      translate([0,0,-1]) cylinder(d=led-led_w*2,h=92,$fn=128);
    }
    
    color("pink") translate([0, 0, led_h]) difference() {
      cylinder(d=led, h=90, $fn=256);
      //cylinder(d=d6, h=90);
    }

    color("purple") {
      translate([-22,0,-1]) cylinder(d=4.2,h=90);
      translate([11,11*sqrt(3),-1]) cylinder(d=4.2,h=90);
      translate([11,-11*sqrt(3),-1]) cylinder(d=4.2,h=90);
    }
    color("dimgray") {  
      translate([-22,0,-0.1]) cylinder(d=10,h=2.2);
      translate([11,11*sqrt(3),-0.1]) cylinder(d=10,h=2.2);
      translate([11,-11*sqrt(3),-0.1]) cylinder(d=10,h=2.2);
    }
   
    color("darkgreen") translate([0,0,pcb_h]) rcube(23.2,23.2,5,2.5);
    
    // pads
    for (i = [90:60:300]) {
      pr=d2/2-1;
      translate([cos(i)*pr, sin(i)*pr, -1]) cylinder(d=9,h=2.5);
    }
    
    hinge();
    wire_clamp([70,0,3]);
    cable();
  }
}

module rcube(w,h,d,r) {
  hull($fn=r*16) {
    translate([w/2-r,-h/2+r,0]) cylinder(r=r,h=d);
    translate([-w/2+r,h/2-r,0]) cylinder(r=r,h=d);
    translate([w/2-r,h/2-r,0]) cylinder(r=r,h=d);
    translate([-w/2+r,-h/2+r,0]) cylinder(r=r,h=d);
  }
}

module screw(pos) {
  translate(pos) {
    cylinder(d=3.3,h=10,$fn=24);
    cylinder(d=6.7,h=4.2,$fn=6);
    cylinder(d=10,h=2.2);
  }
}

module cable() {
  translate([10,2.5,4]) rotate([0,90,0]) cylinder(d=4,h=50);
  translate([10,-2.5,4]) rotate([0,90,0]) cylinder(d=4,h=50);
}

module hinge() {
  color("gray") {
    translate([61,0,1]) rcube(5,50,10,1);
    translate([70,0,3.2]) rcube(22,45,10,1);
    wire_clamp([-75,19,3]);
  }
  color("pink")  translate([0,0,-1]) {
    screw([69,-26]);
    screw([69,26]);
    screw([53,-26]);
    screw([53,26]);
  }
}

module wire_clamp(pos) {
  translate(pos) rotate([0,-90,0]) hull($fn=64) {
    translate([0,-2]) cylinder(d=4,h=20,center=true);
    translate([0,2]) cylinder(d=4,h=20,center=true);
  }
}

module disc() {
  disc_h=16;
  disc_th=4;
  color("darkblue", 0.3) hull () {
    translate([0,0,disc_h]) cylinder(d=disc_d-2,h=disc_th);
    translate([0,0,disc_h]) cylinder(d=disc_d,h=disc_th-1);
  }
}

module nsk6804() {
  translate([0,0,h4]) rotate([0,90,0]) resize([7,32,32]) import("nsk6804.stl");
}
