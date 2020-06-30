function Card(_column, _name, _width, _height, _r, _rM, _o, _oM, _y, _yM, _scheduled, _releaseReady, _released, _a) constructor {
	
	flareHeight = 5;
	width = _width;
	height = _height;
	highlight = false;
	x = -1;
	y = -1;
	shad = 4;
	name = _name;
	activeColumn = _column;
	reqs = {
		red: _r,
		rMax: _rM,
		orange: _o,
		oMax: _oM,
		yellow: _y,
		yMax: _yM,
		scheduled: _scheduled,
		releaseReady: _releaseReady,
		released: _released,
		accepted: _a,
	};
	cardDone = {
		red: "refined",
		orange: "implemented",
		yellow: "tested",
		green: "released"
	};
	
	pointInside = function(_x, _y) {
		return point_in_rectangle(_x, _y, x, y, x + width, y + height);	
	}
	
	draw = function(_x, _y) {
		x = _x;
		y = _y;
		draw_set_color(c_black);
		draw_rectangle(_x + shad, _y + shad, _x + width + shad, _y + height + shad, false);
		draw_set_color(c_white);
		draw_rectangle(_x, _y, _x + width, _y + height, false);
		draw_set_color(c_black);
		
		var titleHeight = string_height_ext(name, 0, width);
		draw_set_font(fntKenney);
		draw_text_ext(_x + 5, _y, name, 0, width);
		
		draw_set_color($dddddd);
		draw_rectangle(_x + 4, _y + titleHeight, _x + width - 4, _y + titleHeight + 1, false)
		
		var remainingHeight = height - titleHeight - 1;
		var barsY = _y + titleHeight + 3;
		var reqBarHeight = (remainingHeight - 5 - flareHeight) / 4;
		var reqBarMargin = 4;
		var reqBarBorderMargin = 2;
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		drawProgressBar(_x, barsY, width, reqBarHeight, reqBarMargin, reqs.red, reqs.rMax, reqBarBorderMargin, global.colours.red, cardDone.red);
		if (reqs.red == reqs.rMax && activeColumn > Columns.BACKLOG) {
			drawProgressBar(_x, (barsY + reqBarHeight), width, reqBarHeight, reqBarMargin, reqs.orange, reqs.oMax, reqBarBorderMargin, global.colours.orange, cardDone.orange);
			if (reqs.orange == reqs.oMax && activeColumn > Columns.DEVELOPMENT) {
				drawProgressBar(_x, (barsY + (2 * reqBarHeight)), width, reqBarHeight, reqBarMargin, reqs.yellow, reqs.yMax, reqBarBorderMargin, global.colours.yellow, cardDone.yellow);
				if (reqs.yellow == reqs.yMax && activeColumn > Columns.TESTING) {
					drawProgressBar(_x, (barsY + (3 * reqBarHeight)), width, reqBarHeight, reqBarMargin, reqs.released, 1, reqBarBorderMargin, global.colours.green, cardDone.green);
				}
			}
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_set_color($dddddd);
		draw_rectangle(_x + 4, _y + titleHeight, _x + width - 4, _y + titleHeight + 1, false)
		draw_rectangle(_x + 4, _y + height - flareHeight, _x + width - 4, _y + height - flareHeight + 1, false)
	}
	
	drawProgressBar = function(_x, _y, _w, _h, _marg, _prog, _max, _bord, _col, _done) {
		var alph = 0.3;
		var bordMargin = _marg - _bord;
		var barWidth = _w - _marg;
		draw_set_color(c_black);
		draw_rectangle(_x + bordMargin, _y + bordMargin, _x + _w - bordMargin, _y + _h - bordMargin, false);
		draw_set_color(c_gray);
		draw_rectangle(_x + _marg, _y + _marg, _x + _w - _marg, _y + _h - _marg, false);
		for (var i = 0; i < _max; i++) {
			
		}
		if (_prog > 0) {
			draw_set_color(_col);
			draw_rectangle(_x + _marg, _y + _marg, _x + ((_w - _marg) * (_prog / _max) ), _y + _h - _marg, false);
			if (_prog == _max) {
				draw_set_alpha(alph);
				draw_set_color(c_white);
				draw_text_transformed(_x + (barWidth / 2) + 2, _y + (_h / 2) + 2, _done, 1, 1, 0)
				draw_set_color(c_black);
				draw_text_transformed(_x + (barWidth / 2), _y + (_h / 2), _done, 1, 1, 0)
				draw_set_alpha(1);
			}
		} else if (_done == cardDone.green && reqs.scheduled) {
			var msg = reqs.releaseReady ? "ready to release" : "scheduled";
			draw_set_color(c_black);
			draw_text_transformed(_x + (barWidth / 2) + 2, _y + (_h / 2) + 2, msg, 1, 1, 0);
			draw_set_color(c_white);
			draw_text_transformed(_x + (barWidth / 2), _y + (_h / 2), msg, 1, 1, 0);
		} else if (_done == cardDone.green && !reqs.scheduled) {
			draw_set_color(c_black);
			draw_text_transformed(_x + (barWidth / 2) + 2, _y + (_h / 2) + 2, "not scheduled", 1, 1, 0);
			draw_set_color(c_white);
			draw_text_transformed(_x + (barWidth / 2), _y + (_h / 2), "not scheduled", 1, 1, 0);	
		}
	}
}