include <keycap_frame.scad>

difference() {
  body();
  leds();
}
buttons();

translate([63,49,2.3]) scale([0.3,0.3,0.3]) import("iidx_teeny_logo.stl");

%color("green", 0.2) pcb();

module pcb() {
  translate([-137.32,146.4,-1.21]) import("iidx_teeny_v1.stl");
}

module body() {
  difference() {
    union() {
      color("silver") translate([0,27,0]) rcube(153,103,3,6.5);
    }
    // main button holes
    color("#2C3E50") {
      main_hole([-54,0]);
      main_hole([-18,0]);
      main_hole([18,0]);
      main_hole([54,0]);
      main_hole([-36,38]);
      main_hole([0,38]);
      main_hole([36,38]);
    }

    // set button holes
    color ("darkgray") translate([0,0,-1]) {
      aux_hole([43,66],1.5);
      aux_hole([54,66],1.5);
      aux_hole([-54,66]);
      aux_hole([-32,66]);
      aux_hole([-10,66]);
      aux_hole([12,66]);
    }

    // screws
    screw([-70,-18]);
    screw([-70,72]);
    screw([70,-18]);
    screw([70,72]);
  }
}

module leds() {
  translate([-54,70]) cube([5,7,4.3],center=true);
  translate([-32,70]) cube([5,7,4.3],center=true);
  translate([-10,70]) cube([5,7,4.3],center=true);
  translate([12,70]) cube([5,7,4.3],center=true);
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

module aux_hole(pos,r=2) {
  translate(pos) {
    hull() {
      rcube(8.8,8.8,2,1);
      rcube(6.3,6.3,4.1,r);
    }
    //rcube(6,6,6,1.7);
  }
}

module aux_button(pos) {
  translate(pos) {
    difference() {
      rcube(11,13.5,0.7,2);
      translate([0,0,-1]) rcube(9.2,11.7,3,1.7);
    }
    difference() {
      rcube(10.4,12.9,1.1,2);
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
    translate([-36,38]) teeny_button();
    translate([0,38]) teeny_button();
    translate([36,38]) teeny_button();
  }

  color("#2C3E50") translate([0,0,2.9]) {
    aux_button([-54,67.5]);
    aux_button([-32,67.5]);
    aux_button([-10,67.5]);
    aux_button([12,67.5]);
    set_button([43,66]);
    set_button([54,66]);
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