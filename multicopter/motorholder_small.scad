module motorplate(armwidth, armheight, motorwidth, motorheight, motorholediameter, thickness) {
	outerwidth = max(armwidth, motorwidth) + 10;
	outerheight = max(armheight, motorheight) + 10;
	holderdepth = max(motorwidth, motorheight);
	union() {
		translate([0,-thickness/2+armwidth/2+thickness/2,(armheight/2)+thickness]) rotate([-90,0,0]) linear_extrude(height=thickness) polygon([[0,0], [depth,0], [0,armheight+2*thickness]]);
		translate([0,-thickness-armwidth/2,(armheight/2)+thickness]) rotate([-90,0,0]) linear_extrude(height=thickness) polygon([[0,0], [depth,0], [0,armheight+2*thickness]]);
		translate([6/2,0,armheight/2+thickness/2]) cube([6,armwidth,thickness],center=true);
	}
	translate([sqrt(pow(outerwidth,2)+pow(outerheight,2))/2,0,armheight/2+thickness/2])
		rotate([0,0,45]) 
			difference() {
				cube([outerwidth, outerheight, thickness], center=true);
				translate([motorheight/2,motorheight/2,0]) cylinder(h=200, d=motorholediameter, center=true, $fn=50);
				translate([-motorheight/2,-motorheight/2,0]) cylinder(h=200, d=motorholediameter, center=true, $fn=50);
				translate([motorheight/2,-motorheight/2,0]) cylinder(h=200, d=motorholediameter, center=true, $fn=50);
				translate([-motorheight/2,motorheight/2,0]) cylinder(h=200, d=motorholediameter, center=true, $fn=50);
				cylinder(h=200, d=10, center=true, $fn=50);
			}
}

module motorholder(armwidth, armheight, armlength, motorwidth, motorheight, thickness, armholediameter, motorholediameter) {
	platesize = max(armwidth, motorwidth, motorheight) + 10;
	outerarmwidth = armwidth + 2*thickness;
	outerarmheight = armheight + 2*thickness;
	union() {
		// armholder
		difference() {
			cube([armlength, outerarmwidth, outerarmheight]);
			translate([-0.5,thickness,thickness]) cube([armlength+1, armwidth, armheight+2*thickness]);
			translate([armlength/6,0,outerarmheight/2]) rotate([90,0,0]) cylinder(h=200, d=armholediameter, center=true, $fn=50);	
			translate([5*armlength/6,0,outerarmheight/2]) rotate([90,0,0]) cylinder(h=200, d=armholediameter, center=true, $fn=50);
		}
		// motorplate motorholediameter + armdepth+max(platewidth, plateheight)/2,outerarmheight/2
		translate([armlength/2,
                 outerarmheight/2,
                 thickness/2]) 
			rotate([0,0,0]) 
				difference() {
//					cube([platesize, platesize, thickness], center=true);
					cylinder(d=platesize*1.3, h=thickness-0.01,center=true, $fn=360);
					translate([-motorwidth/2, -motorheight/2, 0]) cylinder(h=200, d=motorholediameter, center=true, $fn=360);
					translate([motorwidth/2, -motorheight/2, 0]) cylinder(h=200, d=motorholediameter, center=true, $fn=360);
					translate([motorwidth/2, motorheight/2, 0]) cylinder(h=200, d=motorholediameter, center=true, $fn=360);
					translate([-motorwidth/2, motorheight/2, 0]) cylinder(h=200, d=motorholediameter, center=true, $fn=360);
					cylinder(h=200, d=10, center=true, $fn=360);
				}
	}
}

motorholder(armwidth = 13, armheight = 13, armlength = 50, motorwidth = 23, motorheight = 23, thickness = 2.2, armholediameter = 3, motorholediameter = 3);