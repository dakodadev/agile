function Board() constructor {
	
	noOfColumns = 5;
	shad = 4;
	headingHeight = 50;
	seperatorWidth = 6;
	boardMargin = 50;
	cardMargin = 40;
	cardGap = 15;
	columnWidth = (room_width - boardMargin - (seperatorWidth * (noOfColumns + 1))) / noOfColumns;
	cardWidth = columnWidth - cardMargin;
	cardHeight = columnWidth * 0.5;
	x = boardMargin / 2;
	y = boardMargin / 2;
	
	colours = array_create(noOfColumns);
	headers = array_create(noOfColumns);
	columns = array_create(noOfColumns);
	
	fullWidth = function() {
		return (columnWidth * noOfColumns) + (seperatorWidth * (noOfColumns + 1));
	};
	
	columnHeight = function(_gameHeight) {
		return _gameHeight - boardMargin;
	};
	
	init = function() {
		columns[0] = ds_list_create();
		columns[1] = ds_list_create();
		columns[2] = ds_list_create();
		columns[3] = ds_list_create();
		columns[4] = ds_list_create();
		
		headers[0] = "Backlog";
		colours[0] = make_color_rgb(240, 110, 110);
		headers[1] = "Development";
		colours[1] = make_color_rgb(240, 170, 110);
		headers[2] = "Testing";
		colours[2] = make_color_rgb(240, 240, 110);
		headers[3] = "Acceptance";	
		colours[3] = make_color_rgb(110, 240, 110);
		headers[4] = "Done!!";	
		colours[4] = make_color_rgb(110, 240, 240);
		
		ds_list_add(columns[4], new Card("one"));
		ds_list_add(columns[2], new Card("two"));
		ds_list_add(columns[1], new Card("three"));
		ds_list_add(columns[0], new Card("four"));
		ds_list_add(columns[0], new Card("five"));
	}
	
	draw = function(_gameHeight) {
		draw_set_color(c_black);
		draw_rectangle(x + shad, y + headingHeight + shad, x + fullWidth() + shad, y + headingHeight + seperatorWidth + shad, false);
		for (var i = 1; i <= noOfColumns + 1; i++) {
			drawSeperatorShadow(_gameHeight, i);
		}
		drawCards();
		draw_set_color(c_white);
		draw_rectangle(x, y + headingHeight, x + fullWidth(), y + headingHeight + seperatorWidth, false);
		for (var i = 1; i <= noOfColumns + 1; i++) {
			drawSeperator(_gameHeight, i);
		}
		drawHeaders();
		drawHUD(_gameHeight);
	}
	
	drawHeaders = function() {
		draw_set_font(fntKenney);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		for (var i = 1; i <= 5; i++) {
			var coords = getHeadingCoords(i);
			var colour = colours[i - 1];
			coords[0] = coords[0] + (columnWidth / 2)
			coords[1] = coords[1] + (headingHeight / 2);
			draw_text_color(
				coords[0] + 2, coords[1] + 2, headers[i - 1],
				c_black, c_black, c_black, c_black, 1
			)
			draw_text_color(
				coords[0], coords[1], headers[i - 1],
				colour, colour, colour, colour, 1
			)
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
	
	drawSeperator = function(_gameHeight, _num) {
		draw_set_color(c_white);
		draw_rectangle(
			x + ((_num - 1) * (columnWidth + seperatorWidth)),
			y,
			x + ((_num - 1) * (columnWidth + seperatorWidth)) + seperatorWidth,
			y + columnHeight(_gameHeight),
			false
		);	
	}
	
	drawSeperatorShadow = function(_gameHeight, _num) {
		draw_set_color(c_black);
		draw_rectangle(
			x + shad + ((_num - 1) * (columnWidth + seperatorWidth)),
			y + shad,
			x + shad + ((_num - 1) * (columnWidth + seperatorWidth)) + seperatorWidth,
			y + shad + columnHeight(_gameHeight),
			false
		);	
	}
	
	drawCards = function() {
		for(var c = 0; c < array_length(columns); c++) {
			for(var i = 0; i < ds_list_size(columns[c]); i++) {
				drawCard(c + 1, columns[c], i);
			}
		}
	}
	
	drawCard = function(_n, _list, _i) {
		var coords = getColumnCoords(_n);
		ds_list_find_value(_list, _i).draw(coords[0] + (cardMargin / 2), coords[1] + (cardMargin / 2) + (_i * (cardHeight + cardGap)), cardWidth, cardHeight);
	}
	
	drawHUD = function(_gameHeight) {
		draw_set_color(c_gray);
		draw_rectangle(0, _gameHeight, room_width, room_height, false);
	}
	
	getHeadingCoords = function(_col) {
		var a = array_create(2);
		a[0] = x + seperatorWidth + ((_col - 1) * (seperatorWidth + columnWidth));
		a[1] = y;
		return a;
	}
	
	getColumnCoords = function(_col) {
		var a = array_create(2);
		a[0] = x + seperatorWidth + ((_col - 1) * (seperatorWidth + columnWidth));
		a[1] = y + headingHeight + seperatorWidth;
		return a;
	}
}