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
	
};

function boardDraw() {
	game.board.draw(gameHeight());
};

function gameHeight() {
	return room_height - game.hud.height;
}