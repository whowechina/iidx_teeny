hinge_left=true;
hinge_right=false;

body();

//%color("green", 0.2) pcb();

module pcb() {
  translate([-137.32,146.4,5]) import("iidx_teeny_v1.stl");
}


module body() {
  difference() {
    color("silver", 0.8) translate([0,27,0]) rcube(153,103,6.4,6.5);
    color("darkgray") translate([0,27,5]) rcube(150.3,100.3,10,5.15);

    // main button
    color("red") translate([0,0,1.5]) {
      main_button_hole([-54,0]);
      main_button_hole([-18,0]);
      main_button_hole([18,0]);
      main_button_hole([54,0]);

      main_button_hole([-36,38]);
      main_button_hole([0,38]);
      main_button_hole([36,38]);
    }

    // small components
    color("brown") translate([0,0,2]) {
      translate([-56,35]) rcube(10,10,10,2);
      translate([3.7,18.75]) rcube(6,6,10,1);
    }
    
    // TT wiring
    color("brown") translate([0,0,1]) {
      translate([39,19]) rcube(44,16,10,2);
      translate([-37,19]) rcube(46,16,10,2);

      translate([1.5,42.6]) rcube(39,28,10,2);
      translate([14.5,56]) rcube(13,10,10,1);
      
      translate([-13,29]) rotate([0,0,55]) rcube(25,15,10,0.1);
      translate([16,29]) rotate([0,0,-55]) rcube(25,15,10,0.1);
    }
    
    // pi pico area
    color("cyan") translate([0,0,1.5]) {
      translate([-39,59,0]) rcube(55,25,10,1);
      translate([-17,59,-0.7]) rcube(11,12,10,1);
      translate([-26.5,55.5,-3]) cylinder(d=3,h=10,$fn=32); // reset button
    }

    // usb
    translate([0,0,6.7]) {
      color("blue") translate([1,77.1,0]) rotate([90,0,0]) rcube(9.5,10,18,1);
      color("red") translate([1,86,-3]) rotate([90,0,0]) rcube(8.6,2.7,10,1.3);      
    }
  
    // screws
    color("pink")  translate([0,0,-1]) {
      screw([-70,-18]);
      screw([70,-18]);
      screw([70,72]);
      screw([-70,72]);
    }
    
    // TT hinge junction
    if (hinge_left) color("gray") {
      translate([-75,24,2.5]) rcube(6,41,10,1);
      difference() {
        translate([-65,24,1]) rcube(16,41,10,0.1);
        translate([-66,14,1]) rcube(4,8,10,1);
        translate([-66,34,1]) rcube(4,8,10,1);
      }
      wire_clamp([-75,24,3]);
    }
    if (hinge_right) color("gray") {
      translate([75,24,2.5]) rcube(6,41,10,1);
      difference() {
        translate([65,24,1]) rcube(16,41,10,0.1);
        translate([66,14,1]) rcube(4,8,10,1);
        translate([66,34,1]) rcube(4,8,10,1);
      }      
      wire_clamp([75,24,3]);
    }
    
  }
}

module wire_clamp(pos) {
  translate(pos) rotate([0,-90,0]) hull($fn=64) {
    translate([0.6,-1.2]) cylinder(d=6,h=36,center=true);
    translate([0.6,1.2]) cylinder(d=6,h=36,center=true);
  }
}

module screw(pos) {
  translate(pos) {
    cylinder(d=3.3,h=10,$fn=24);
    cylinder(d=6.7,h=4.6,$fn=6);
    cylinder(d=9.5,h=2.2,$fn=32);
  }
}

module main_button_hole(pos)
{
  translate(pos) rcube(18,18.5,10,1); 
}

module rcube(w,h,d,r) {
  hull($fn=r*16) {
    translate([w/2-r,-h/2+r,0]) cylinder(r=r,h=d);
    translate([-w/2+r,h/2-r,0]) cylinder(r=r,h=d);
    translate([w/2-r,h/2-r,0]) cylinder(r=r,h=d);
    translate([-w/2+r,-h/2+r,0]) cylinder(r=r,h=d);
  }
}