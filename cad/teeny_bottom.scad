hinge_left=true;
hinge_right=false;

body();

*%color("green", 0.2) pcb();

module pcb() {
  translate([-137.32,144.4,5]) import("iidx_teeny v1.stl");
}

module body() {
  difference() {
    color("silver", 0.8) translate([0,25,0]) rcube(153,103,6.4,6.5);
    color("darkgray") translate([0,25,5]) rcube(150.3,100.3,10,5.15);

    // main button
    color("red") translate([0,0,1.5]) {
      main_button_hole([-54,0]);
      main_button_hole([-18,0]);
      main_button_hole([18,0]);
      main_button_hole([54,0]);

      main_button_hole([-36,36]);
      main_button_hole([0,36]);
      main_button_hole([36,36]);
    }

    // small components
    color("brown") translate([0,0,2]) {
      translate([-56,33]) rcube(10,10,10,2);
      translate([3.7,16.75]) rcube(6,6,10,1);
    }
    
    // TT wiring
    color("brown") translate([0,0,1]) {
      translate([36,18]) rcube(50,14,10,2);
      translate([-34,18]) rcube(52,14,10,2);

      translate([0,47]) rcube(36,16,10,2);
      translate([14.5,54]) rcube(13,10,10,1);
      translate([-13,30]) rcube(10,32,10,1);
      translate([16,35]) rcube(10,32,10,1);
    }
    
    // pi pico area
    color("cyan") translate([0,0,1.5]) {
      translate([-39,57,0]) rcube(55,25,10,1);
      translate([-17,57,-0.7]) rcube(11,12,10,1);
      translate([-26.5,53.5,-3]) cylinder(d=3,h=10,$fn=32); // reset button
    }

    // usb
    color("cyan") translate([0,0,6.7]) {
      translate([1,78,0]) rotate([90,0,0]) rcube(9.5,10,20,1);
    }
  
    // screws
    color("pink")  translate([0,0,-1]) {
      screw([-70,-20]);
      screw([70,-20]);
      screw([70,70]);
      screw([-70,70]);
    }
    
    // TT hinge junction
    if (hinge_left) color("gray") {
      translate([-75,20,2.5]) rcube(6,41,10,1);
      difference() {
        translate([-65,20,1]) rcube(16,41,10,0.1);
        translate([-66,10,1]) rcube(4,8,10,1);
        translate([-66,30,1]) rcube(4,8,10,1);
      }
      wire_clamp([-75,20,3]);
    }
    if (hinge_right) color("gray") {
      translate([75,20,2.5]) rcube(6,41,10,1);
      difference() {
        translate([65,20,1]) rcube(16,41,10,0.1);
        translate([66,10,1]) rcube(4,8,10,1);
        translate([66,30,1]) rcube(4,8,10,1);
      }      
      wire_clamp([75,20,3]);
    }
    
  }
}

module wire_clamp(pos) {
  translate(pos) rotate([0,-90,0]) hull($fn=64) {
    translate([0.6,-1.2]) cylinder(d=6,h=45,center=true);
    translate([0.6,1.2]) cylinder(d=6,h=45,center=true);
  }
}

module screw(pos) {
  translate(pos) {
    cylinder(d=3.3,h=10,$fn=24);
    cylinder(d=6.7,h=4.2,$fn=6);
    cylinder(d=9.5,h=1.8,$fn=32);
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