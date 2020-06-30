function Board() constructor {
	
	noOfColumns = 6;
	shad = 4;
	headingHeight = 50;
	seperatorWidth = 2;
	boardMargin = 50;
	cardMargin = 25;
	cardGap = 10;
	columnWidth = (room_width - boardMargin - (seperatorWidth * (noOfColumns + 1))) / noOfColumns;
	cardWidth = columnWidth - cardMargin;
	cardHeight = columnWidth * 0.6;
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
		columns[5] = ds_list_create();
		
		headers[0] = "Backlog";
		colours[0] = global.colours.red;
		headers[1] = "Development";
		colours[1] = global.colours.orange;
		headers[2] = "Testing";
		colours[2] = global.colours.yellow;
		headers[3] = "Release";	
		colours[3] = global.colours.green;
		headers[4] = "Acceptance";	
		colours[4] = global.colours.blue;
		headers[5] = "Done";	
		colours[5] = global.colours.pink;
		
		ds_list_add(columns[Columns.DONE], new Card(Columns.DONE, "A", cardWidth, cardHeight, 5, 5, 4, 4, 2, 2, true, true, true, false));
		ds_list_add(columns[Columns.RELEASE], new Card(Columns.RELEASE, "B", cardWidth, cardHeight, 5, 5, 4, 4, 2, 2, true, true, false, false));
		ds_list_add(columns[Columns.RELEASE], new Card(Columns.RELEASE, "C", cardWidth, cardHeight, 5, 5, 4, 4, 2, 2, true, false, false, false));
		ds_list_add(columns[Columns.RELEASE], new Card(Columns.RELEASE, "D", cardWidth, cardHeight, 5, 5, 4, 4, 2, 2, false, false, false, false));
		ds_list_add(columns[Columns.TESTING], new Card(Columns.TESTING, "E", cardWidth, cardHeight, 4, 4, 3, 3, 1, 5, false, false, false, false));
		ds_list_add(columns[Columns.DEVELOPMENT], new Card(Columns.DEVELOPMENT, "F", cardWidth, cardHeight, 5, 5, 2, 7, 0, 4, false, false, false, false));
		ds_list_add(columns[Columns.DEVELOPMENT], new Card(Columns.DEVELOPMENT, "G", cardWidth, cardHeight, 5, 5, 7, 7, 0, 4, false, false, false, false));
		ds_list_add(columns[Columns.DEVELOPMENT], new Card(Columns.DEVELOPMENT, "H", cardWidth, cardHeight, 5, 5, 6, 10, 0, 4, false, false, false, false));
		ds_list_add(columns[Columns.BACKLOG], new Card(Columns.BACKLOG, "I", cardWidth, cardHeight, 3, 6, 0, 2, 0, 1, false, false, false, false));
		ds_list_add(columns[Columns.BACKLOG], new Card(Columns.BACKLOG, "J", cardWidth, cardHeight, 0, 2, 0, 0, 0, 0, false, false, false, false));
	}
	
	step = function() {
		for(var c = 0; c < noOfColumns; c++) {
			var list = columns[c];
			for(var i = 0; i < ds_list_size(list); i++) {
				var card = ds_list_find_value(list, i);
				if (card.pointInside(mouse_x, mouse_y)) {
					card.highlight = true;
				} else {
					card.highlight = false;
				}
			}
		}
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
		var tShad = 3;
		var scale = 1.5;
		draw_set_font(fntKenney);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		for (var i = 1; i <= noOfColumns; i++) {
			var coords = getHeadingCoords(i);
			var colour = colours[i - 1];
			coords[0] = coords[0] + (columnWidth / 2)
			coords[1] = coords[1] + (headingHeight / 2);
			draw_text_transformed_color(
				coords[0] + tShad, coords[1] + tShad, headers[i - 1],
				scale, scale, 0,
				c_black, c_black, c_black, c_black, 1
			)
			draw_text_transformed_color(
				coords[0], coords[1], headers[i - 1],
				scale, scale, 0,
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