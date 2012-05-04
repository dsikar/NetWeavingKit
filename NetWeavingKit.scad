/*********************

	Net Weaving Needle Kit

**********************/

/* START MODULES */

module net_weaving_needle()
{
	difference(){	

		union(){
			// Main body
			translate([0,1.5,0])
			// cube([17,148.5,2]); // 148.5 - 13.5 = 135
			cube([17,135,2]);
		
			// Bottom left round trim
			translate([1.5,1.5,0])
			cylinder(h = 2, r =1.5, $fn = 100);

			// Bottom right round trim
			translate([15.5,1.5,0])
			cylinder(h = 2, r =1.5, $fn = 100);

			// Tip - Height = 13.5mm
			translate([15,136.5,0])
			intersection() {
				cylinder(h = 2, r =15, $fn = 100);
				translate([-13,0,0])
				cylinder(h = 2, r =15, $fn = 100);
				translate([-17,0,0])
				cube([20,15,2]);
			}
		}

		// Bottom round gap
		translate([8.5,12,0])
		cylinder(h = 2, r =5.5, $fn = 100);

		// Bottom square gap
		translate([3,1.5,0])
		cube([11,11,2]);

		// Left threading gap
		translate([3,94.5,0])
		cube([4,36.5,2]);

		// Left threading gap bottom left round trim
		translate([5,94.5,0])
		cylinder(h = 2, r =2, $fn = 100);

		// Right threading gap
		translate([10,94.5,0])
		cube([4,36.5,2]);

		// Right threading gap bottom right round trim
		translate([12,94.5,0])
		cylinder(h = 2, r =2, $fn = 100);

		// Threading gap tip

		translate([0,122,0])
		difference(){
				// tip
				translate([15,0,0])
				intersection(){
					cylinder(h = 2, r =15, $fn = 100);
					translate([-13,0,0])
					cylinder(h = 2, r =15, $fn = 100);

					translate([-12,0,0])
					cube([11,16.4,2]);
				}

				// Bottom edge trim
				translate([3,0,0])
				cube([11,9,2]);

				// Bottom round indentation - to match mid threading rod rounded edge
				translate([8.5,9,0])
				
				difference(){
					cylinder(h = 2, r =1.5, $fn = 100);
					translate([-1.5,-1.5,0])
					cube([3,1.5,2]);
				}
		}
	}
}

// @ symbol, r= 5.5
module at_symbol()
{
	union() {
		difference() {
			union() {

				difference() {
					// outer circle
					cylinder(h=3, r=5.5,$fn=100);
					cylinder(h=3, r=3.5,$fn=100);

				}
				// inner circle
				translate([0.5,0,0])
				cylinder(h=3, r=1.5,$fn=100);

			}

			// gap
			translate([1.5,-5.5,0])
			cube([4,5.5,3]);	

			// tail trim
			translate([0,-5.5,0])
			cube([3,2.5,3]);	


		}
		//link
		translate([2.75,0.1,0])
			difference() {
					cylinder(h=3, r=2.75,$fn=100);
					cylinder(h=3, r=0.75,$fn=100);
					translate([-2.75,0,0])
					cube([5.5, 2.75, 3]);
		}

		// extended tail 
		translate([0,-5.5,0])
		cube([0.5,2,3]);	
	}
}


// less than sign - h ~ 11, w = 10.85
module less_than()
{
	difference(){

		// Main shape
		union(){
			rotate(a=[0,0,24.15]) {
				translate([0,-2,0])
				cube([11.88,2,3]);	
			}

			rotate(a=[0,0,335.85]) {
				cube([11.88,2,3]);	
			}
		}

		// left trim
		translate([10.85,-5.5,0])
		cube([2,11,3]);	

		// top trim
		rotate(a=[0,0,24.15]) {
			cube([2.75,2,3]);	
		}

		// bottom trim
		rotate(a=[0,0,-24.15]) {
			translate([0,-2,0])
			cube([2.75,2,3]);	
		}
	}
}

// greater than sign
module greater_than()
{
	rotate(a=[0,0,180]) {
		less_than();
	}
	
}

// ascii fish
module ascii_fish()
{
	translate([-17.35,0,0])
	less_than();

	at_symbol();

	translate([17.35,0,0])
	greater_than();

	translate([29.20,0,0])
	greater_than();

	translate([30.70,0,0])
	less_than();
}

// ascii fish with invert at symbol
module ascii_fish2()
{
	translate([-17.35,0,0])
	less_than();

	rotate(a=[0,0,180]) {
		at_symbol();
	}

	translate([17.35,0,0])
	greater_than();

	translate([29.20,0,0])
	greater_than();

	translate([30.70,0,0])
	less_than();
}

// base board
module base_board() {
	// base shape
	translate([0,4,0])
	cube([34,58.9,2]);

	// BL edge
	translate([4,4,0])
	cylinder(h=2, r=4,$fn=100);

	// BR edge
	translate([30,4,0])
	cylinder(h=2, r=4,$fn=100);

	// bottom edge fill
	translate([4,0,0])
	cube([26,4,2]);

	// TL edge
	translate([4,62.9,0])
	cylinder(h=2, r=4,$fn=100);

	// TR edge
	translate([30,62.9,0])
	cylinder(h=2, r=4,$fn=100);

	// top edge fill
	translate([4,62.9,0])
	cube([26,4,2]);
}

module weaving_board() {
	difference() {
		base_board();

		translate([9.50,45.55,-0.5])
		rotate(a=[0,0,-90]) {
			ascii_fish();
		}

		translate([24.50,21.35,-0.5])
		rotate(a=[0,0,90]) {
			ascii_fish2();
		}
	}
}

module ring() {
	difference() {
		cylinder(h=3, r=15,$fn=100);
		cylinder(h=3, r=13.5,$fn=100);
	}
}


difference() {
	net_weaving_needle();
	translate([8.50,67,-0.5])
	rotate(a=[0,0,-90]) {
		ascii_fish();
	}
}


translate([21,21.5,0])
weaving_board();

translate([38,104.75,0])
ring();

translate([38,136,0])
ring();

