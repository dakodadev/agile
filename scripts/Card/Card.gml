function Card(_name) constructor {
	
	shad = 4;
	name = _name;
	reqs = {
		yellow: 5,
		green: 5,
		blue: 5
	}
	
	draw = function(_x, _y, _width, _height) {
		draw_set_color(c_black);
		draw_rectangle(_x + shad, _y + shad, _x + _width + shad, _y + _height + shad, false);
		draw_set_color(c_white);
		draw_rectangle(_x, _y, _x + _width, _y + _height, false);	
	}
}