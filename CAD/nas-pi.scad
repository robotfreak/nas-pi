use <roundedCube.scad>
use <fan_grill.scad>
$fn=30;

grillHoleDiameter = 110;
grillPatternElementsInRow = 6;
// Used differently for varius patterns, just experiment with it
grillPatternElementsDistance = 2;
grillThickness = 2.4;

module front_plate() {
    difference() {
        roundedCube([180, 50, 2], r=3, x=false, z=true);
        translate([32,14,0]) cylinder(d=12, h=6);
        translate([32,33,0]) cylinder(d=12, h=6);
        translate([77,28,0]) cube([32,32,6], center=true);
        translate([126,10,0]) cylinder(d=3.5, h=6);
        translate([133.5,10,0]) cylinder(d=3.5, h=6);
        translate([5,17.5,0]) cylinder(d=4, h=6);
        translate([175,17.5,0]) cylinder(d=4, h=6);
    }
}

module hdd_plate() {
    difference() {
        roundedCube([180,110, 2], r=3, x=false, z=true);
        translate([40,5,0]) roundedCube([120,100, 2], r=3, x=false, z=true);
    translate([5,40,0]) cylinder(d=4, h=6);
    translate([175,40,0]) cylinder(d=4, h=6);
    }
    translate([40,5,0]) intersection() {
        roundedCube([120,100, 2], r=3, x=false, z=true);
        difference() {    
            roundedCube([120,100, 2], r=3, x=false, z=true);
            linear_extrude(grillThickness)
            _honeycombPatternPlane();
        }
    }
}

module back_plate() {
    difference() {
        roundedCube([180, 36, 2], r=3, x=false, z=true);
        translate([12,13,0]) cylinder(d=12, h=6);
        translate([20+23,11,0]) cube([20,8,6], center=true);
        translate([20+23+25,11,0]) cube([20,8,6], center=true);
        translate([20+23+25+26,14,0]) cube([16,14,6], center=true);
        translate([20+23+25+26+19,15,0]) cube([16,16,6], center=true);    translate([20+23+25+26+19+15,9,0]) cube([10,5,6], center=true);
        translate([0,27,0]) cylinder(d=7, h=6);
        translate([180,27,0]) cylinder(d=7, h=6);
        translate([165,27,0]) cylinder(d=3, h=6);
    }
}

module back_plate2() {
    difference() {
        roundedCube([120, 46, 2], r=3, x=false, z=true);
        translate([20,35,-2]) cylinder(d=7, h=3);
        translate([50,35,-2]) cylinder(d=7, h=3);
    }
}

module back_plate3() {
    difference() {
        roundedCube([120, 20, 2], r=3, x=false, z=true);
        translate([20,13,-2]) cylinder(d=7, h=3);
        translate([50,13,-2]) cylinder(d=7, h=3);
    }
}

module fan_plate() {
    fan();
    translate([120,3,0]) rotate([0,0,180]) back_plate2();
    translate([120,137,0]) rotate([0,0,180]) back_plate3();
}

module cm4io_carrier_board() {
    difference() {
        union() {
            roundedCube([160, 90, 3], r=3, x=false, z=true);
            translate([3.5,3.5,0]) cylinder(d=7, h=8);
            translate([3.5,52.5,0]) cylinder(d=7, h=8);
            translate([11,8,0]) cylinder(d=7, h=8);
            translate([11,77,0]) cylinder(d=7, h=8);
            translate([61.5,3.5,0]) cylinder(d=7, h=8);
            translate([61.5,52.5,0]) cylinder(d=7, h=8);
            translate([145,8,0]) cylinder(d=7, h=8);
            translate([145,77,0]) cylinder(d=7, h=8);
        }
        translate([145,8,0]) cylinder(d=9, h=8);
        translate([17,5,0]) roundedCube([38, 80, 3], r=3, x=false, z=true);
        translate([68,5,0]) roundedCube([70, 80, 3], r=3, x=false, z=true);
        translate([135,20,0]) roundedCube([15, 50, 3], r=3, x=false, z=true);
        translate([3.5,3.5,0]) cylinder(d=3, h=8);
        translate([3.5,52.5,0]) cylinder(d=3, h=8);
        translate([11,8,0]) cylinder(d=3, h=8);
        translate([11,77,0]) cylinder(d=3, h=8);
        translate([61.5,3.5,0]) cylinder(d=3, h=8);
        translate([61.5,52.5,0]) cylinder(d=3, h=8);
        translate([145,8,0]) cylinder(d=3, h=8);
        translate([145,77,0]) cylinder(d=3, h=8);
    }
}

module standup() {
    difference() {
        cylinder(d=7,h=8);
        cylinder(d=3,h=8);
    }
}

module _honeycombPatternPlane()
{
    circleDimension = grillHoleDiameter / grillPatternElementsInRow - grillPatternElementsDistance;
    XTranslation = (circleDimension * 0.75 + grillPatternElementsDistance * sqrt(3) / 2);
    YTranslation = (circleDimension / 2 * sqrt(3) + grillPatternElementsDistance);

    translate([grillPatternElementsDistance / 2, grillPatternElementsDistance / 2, 0])
    for(i = [0 : grillPatternElementsInRow * 2])
    {
        for(j = [0 : grillPatternElementsInRow * 2])
        {
                translate([XTranslation * i, YTranslation * (j + 0.5 * (i % 2)), 0])
                    circle(d = circleDimension, $fn = 6);
        }
    }

}

module powerSupplyCarrier() {
    difference() {
        roundedCube([90, 60, 2], r=3, x=false, z=true);
        translate([17,20,0])roundedCube([56, 20, 2], r=3, x=false, z=true);
        translate([5,5,0]) cylinder(d=4, h=3);
        translate([85,55,0]) cylinder(d=4, h=3);
        translate([5,55,0]) cylinder(d=4, h=3);
        translate([85,5,0]) cylinder(d=4, h=3);
        translate([25,15,0]) cylinder(d=4, h=3);
        translate([65,15,0]) cylinder(d=4, h=3);
        translate([25,45,0]) cylinder(d=4, h=3);
        translate([65,45,0]) cylinder(d=4, h=3);
    }
    translate([35,12,2]) roundedCube([20,4,4], r=2, x=false, z=true);
    translate([35,44,2]) roundedCube([20,4,4], r=2, x=false, z=true);
}

fan_plate();
//powerSupplyCarrier();
//standup();
//translate([10,0,0]) standup();
//hdd_plate();
//front_plate();
//back_plate();
//back_plate2();
//cm4io_carrier_board();
        