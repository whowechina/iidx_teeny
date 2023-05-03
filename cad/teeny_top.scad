include <keycap_frame.scad>

difference() {
  body();
  leds();
}
buttons();

translate([63,47,2.3]) scale([0.3,0.3,0.3]) import("iidx_teeny_logo.stl");

%color("green", 0.8) pcb();

module pcb() {
  translate([-137.32,144.4,-1.21]) import("iidx_teeny v1.stl");
}

module body() {
  difference() {
    union() {
      color("silver") translate([0,25,0]) rcube(153,103,3,6.5);
    }
    // main button holes
    color("#2C3E50") {
      main_hole([-54,0]);
      main_hole([-18,0]);
      main_hole([18,0]);
      main_hole([54,0]);
      main_hole([-36,36]);
      main_hole([0,36]);
      main_hole([36,36]);
    }

    // set button holes
    color ("darkgray") translate([0,0,-1]) {
      aux_hole([43,64]);
      aux_hole([54,64]);
      aux_hole([-54,64]);
      aux_hole([-32,64]);
      aux_hole([-10,64]);
      aux_hole([12,64]);
    }

    // pogo holes
    translate([-48.92,121.5,0]) rotate([0,0,90]) pogo_hole();
    translate([86.6,74.42,0]) rotate([0,0,0]) pogo_hole();
    // usb hole
    translate([-16.72,121.4]) usb_hole();

    // screws
    screw([-70,-20]);
    screw([-70,70]);
    screw([70,-20]);
    screw([70,70]);
  }
}

module leds() {
  translate([-54,68]) cube([5,7,4.5],center=true);
  translate([-32,68]) cube([5,7,4.5],center=true);
  translate([-10,68]) cube([5,7,4.5],center=true);
  translate([12,68]) cube([5,7,4.5],center=true);
}

module screw(pos) {
  color("gray") translate(pos) {
    translate([0,0,-1],$fn=24) cylinder(d=3.4,h=10);
    translate([0,0,1.5],$fn=24) cylinder(d=6,h=10);
 }
}

module main_hole(pos)
{
  translate(pos) cube([21.2,29.2,20],center=true);
}

module aux_hole(pos) {
  translate(pos) {
    hull() {
      rcube(7,8.8,2.5,1);
      rcube(7,7,4.1,2);
    }
    rcube(7,7,6,2);
  }
}

module pogo_hole()
{
  rotate([90,0,0]) resize([3,4.5,14]) cylinder(d=1,h=1,center=true,$fn=32);
}

module usb_hole()
{
  translate([4.3,0]) rotate([90,0,0]) resize([1.6,2,6]) cylinder(d=1,h=1,center=true,$fn=32);
  translate([-4.3,0]) rotate([90,0,0]) resize([1.6,2,6]) cylinder(d=1,h=1,center=true,$fn=32);
}

module aux_button(pos) {
  translate(pos) difference() {
    hull() {
      rcube(9,12,1,2);
      rcube(10.5,13.5,0.1,2.75);
    }
    translate([0,0,-1]) rcube(7.5,10.5,6,2);
  }
}

module set_button(pos) {
  translate(pos) difference() {
    hull() {
      rcube(8.5,8.5,1,2);
      rcube(10,10,0.1,2.75);
    }
    translate([0,0,-1]) rcube(7,7,6,2);
  }
}

module buttons() {
  color("#2C3E50") translate([0,0,2.99]) {
    translate([-54,0]) teeny_button();
    translate([-18,0]) teeny_button();
    translate([18,0]) teeny_button();
    translate([54,0]) teeny_button();
    translate([-36,36]) teeny_button();
    translate([0,36]) teeny_button();
    translate([36,36]) teeny_button();
  }

  color ("#2C3E50") translate([0,0,2.9]) {
    aux_button([-54,65.5]);
    aux_button([-32,65.5]);
    aux_button([-10,65.5]);
    aux_button([12,65.5]);
    set_button([43,64]);
    set_button([54,64]);
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