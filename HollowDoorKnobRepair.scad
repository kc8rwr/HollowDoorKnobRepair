/* [Bolt Settings] */
// Bolt hole diameter
bolt_diameter = 4.25;
// Bolt head recess diameter
bolt_head_diameter = 8;
// Bolt head recess depth
bolt_head_height = 4;

/* [Backing Settings] */
// Backing Diameter
backing_diameter = 45;
// Thickness of overhang on back of door
backing_thickness = 3;
// Back of door hole diameter
back_hole_diameter = 31.8;
// Width of the door
door_width = 30.5;

// Diameter of hole in the front of the door
front_hole_diameter = 10.8;
// Diameter of the front part covering the front hole
front_hole_cover = 15;
// Thickness of the front surface of the door
front_door_surface_thickness = 2;
// Thickness of the part covering the front hole
front_thickness = 1.5;

/* [Knob Settings] */
// Diameter of the knob shaft recess
knob_shaft_diameter = 9.5;

/* [Misc] */
//Extra clearance where the two pieces come together
locking_clearance = 0.5;

$fn = $preview ? 36 : 360;

module backing(bolt_diameter = 4,
   bolt_head_diameter = 6,
   bolt_head_height = 4,
   backing_diameter = 45,
   backing_thickness = 3,
   back_hole_diameter = 31.8,
   door_width = 30.53,
   front_hole_diameter = 10.8,
   locking_clearance = 1){

   difference(){
      union(){
         cylinder(d1=backing_diameter - 2, d2=backing_diameter, h=backing_thickness);
         cylinder(d=back_hole_diameter, h=door_width - front_door_surface_thickness + backing_thickness);
      }
      translate([0, 0, -1]){
         cylinder(d = bolt_diameter, h = 2 + backing_thickness + door_width - front_door_surface_thickness);
         cylinder(d=bolt_head_diameter, h=bolt_head_height + 1);
      }
      translate([0, 0, backing_thickness + ((door_width - front_door_surface_thickness) / 2)]){
         cylinder(d = front_hole_diameter + locking_clearance, h = 1 + ((door_width - front_door_surface_thickness)/2));
      }
   }
}

module front(bolt_diameter = 4,
   front_thickness = 1.5,
   front_hole_diameter = 10.8,
   door_width = 30.53,
   front_hole_diameter = 10.8,
   front_hole_cover = 15,
   front_door_surface_thickness = 2,
   locking_clearance = 1){

   difference(){
      union(){
         cylinder(d1=front_hole_cover - 2, d2=front_hole_cover, h=front_thickness);
         cylinder(d=front_hole_diameter, h=((door_width - front_door_surface_thickness)/2) + front_door_surface_thickness + front_thickness);
      }
      translate([0, 0, -1]){
         cylinder(d = bolt_diameter, h = 2 + front_door_surface_thickness + front_thickness + ((door_width - front_door_surface_thickness)/2));
         difference(){
            cylinder(d=knob_shaft_diameter, h=front_thickness + 1);
            translate([0, 0, -1]){
               cylinder(d=bolt_diameter + 1, h=front_thickness + 3);
            }
         }
      }
   }
}

backing(bolt_diameter = bolt_diameter,
   bolt_head_diameter = bolt_head_diameter,
   bolt_head_height = bolt_head_height,
   backing_diameter = backing_diameter,
   backing_thickness = backing_thickness,
   back_hole_diameter = back_hole_diameter,
   door_width = door_width,
   front_hole_diameter = front_hole_diameter,
   locking_clearance = locking_clearance);

translate([4+(backing_diameter/2) + (front_hole_cover/2), 0, 0]){
   front(bolt_diameter = bolt_diameter,
      front_hole_cover = front_hole_cover,
      front_thickness = front_thickness,
      front_door_surface_thickness = front_door_surface_thickness,
      door_width = door_width,
      front_hole_diameter = front_hole_diameter,
      locking_clearance = locking_clearance);
}