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
  translate([-54,68]) cube([5,7,4.3],center=true);
  translate([-32,68]) cube([5,7,4.3],center=true);
  translate([-10,68]) cube([5,7,4.3],center=true);
  translate([12,68]) cube([5,7,4.3],center=true);
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
      rcube(7,8.8,2,1);
      rcube(6,6,4.1,2);
    }
    //rcube(6,6,6,1.7);
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
  translate(pos) {
    difference() {
      rcube(11,12.5,0.6,2);
      translate([0,0,-1]) rcube(9.2,10.7,3,1.7);
    }
    difference() {
      rcube(10.4,11.9,1,2);
      translate([0,0,-1]) rcube(9.8,11.3,3,1.7);
    }
  }
}

module set_button(pos) {
  translate(pos) {
    difference() {
      rcube(10,10,0.6,2);
      translate([0,0,-1]) rcube(8.2,8.2,3,1.7);
    }
    difference() {
      rcube(9.4,9.4,1,2);
      translate([0,0,-1]) rcube(8.8,8.8,3,1.7);
    }
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

  color("#2C3E50") translate([0,0,2.9]) {
    aux_button([-54,65]);
    aux_button([-32,65]);
    aux_button([-10,65]);
    aux_button([12,65]);
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