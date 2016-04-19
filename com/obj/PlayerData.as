package com.kg.obj {


	/**
	 * Defines a class that is used to store the current player's state. (score, lives, level, etc.)
	 */
	public class PlayerData {

		/**
		 * The score that the player has.
		 */
		public var score: Number = 0;

		/**
		 * The number of lives that the player has left.
		 */
		public var livesLeft: int = 3;

		/**
		 * The player object that currently exists in the game.
		 */
		public var player: MovingObject;

		/**
		 * Creates a new PlayerData object that can be used to store a player's state in the game.
		 */
		public function PlayerData(player: MovingObject) {
			this.player = player;
		}

	}

}
