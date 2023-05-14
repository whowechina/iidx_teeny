magnet=[6,2]; // define your magnet: [diameter, thickness]
sd=6; 
ss=2.95;
f=2.3;

shaft6804();

%magnet();


module shaft6804() {
  difference() {
    union($fn=256) {
      cylinder(d=20.2,h=7+f);
      cylinder(d=24,h=f);
    }
    translate([0,0,7+f-0.3]) cylinder(d=18,h=3,$fn=64);
    core();
  }

  %nsk6804();
}

module core() {
  color("cyan") translate([0,0,8.5-magnet[1]]) cylinder(d=magnet[0]+0.3,h=10,$fn=64); // magnet

  color("gray") for (i=[0:90:270]) {
    hole(i);
  }  
}

module hole(angle) {
  $fn=64;
  x = cos(angle)*sd;
  y = sin(angle)*sd;
  translate([x,y,-1]) cylinder(d=ss,h=14);
  hull() {
    translate([x,y,-0.1]) cylinder(d=ss,h=2);
    translate([x,y,-0.1]) cylinder(d=ss+1.2,h=0.1);
  }
}

module nsk6804() {
  translate([0,0,f]) rotate([0,90,0]) resize([7,32,32]) import("nsk6804.stl");
}

module magnet() {
  translate([0,0,8.9-magnet[1]]) cylinder(d=magnet[0],h=magnet[1],$fn=64);
}
