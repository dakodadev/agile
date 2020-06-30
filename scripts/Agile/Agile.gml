global.colours = {
	red: make_color_rgb(255, 103, 61),
	orange: make_color_rgb(252, 172, 129),
	yellow: make_color_rgb(252, 207, 129),
	green: make_color_rgb(252, 248, 129),
	blue: make_color_rgb(223, 252, 129),
	pink: make_color_rgb(135, 252, 129),
	get: function(_n) {
		switch(_n) {
			case 0: return red;
			case 1: return orange;	
			case 2: return yellow;	
			case 3: return green;	
			case 4: return blue;	
			case 5: return pink;	
		}
	}
}

enum Columns {
	BACKLOG = 0,
	DEVELOPMENT = 1,
	TESTING = 2,
	RELEASE = 3,
	ACCEPTANCE = 4,
	DONE = 5,
}

function boardInitialise() {
	game = {
		board: new Board(),
		hud: {
			height: 150,
		},
	};
	game.board.init();
};

function boardStep() {
	game.board.step();
};

function boardDraw() {
	game.board.draw(gameHeight());
};

function gameHeight() {
	return room_height - game.hud.height;
}