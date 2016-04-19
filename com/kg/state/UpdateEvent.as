package com.kg.state {

	import com.kg.obj.PlayerData;

	/**
	 * Defines a class that represents a event update events.
	 */
	public class UpdateEvent {

		/**
		 * The amount of time that has passed between the
		 * last frame time and the current frame time.
		 * Compensated for the frame rate.
		 */
		public var deltaTime: Number = 0;

		/**
		 * The time that this update loop began at in seconds.
		 * This value is perfectly fine to use for game related calculations, because it is
		 * attached to delta time. Do not, however, assume a fixed time step, or even that currentTime always grows to
		 * larger and larger positive values.
		 */
		public var currentTime: Number;

		/**
		 * The current state of the player.
		 */
		public var playerData: PlayerData;

		/**
		 * The object that is in charge of the game state.
		 */
		public var game: GameManager;

		/**
		 * Whether the game is currently paused.
		 */
		public var isPaused: Boolean = false;

		/**
		 * The keyboard events that have occurred for this frame.
		 */
		public var keys: Keys;

		/**
		 * Creates a new UpdateEvent Object using the given frame deltaTime and current frame time.
		 * @param deltaTime:Number The amount of time between this frame and the previous in milliseconds.
		 * @param currentTime:Number The current game time in milliseconds.
		 * @param game:SinuousGame The object that is in charge of the game state.
		 */
		public function UpdateEvent(deltaTime: Number, currentTime: Number, game: GameManager, keys: Keys) {
			this.deltaTime = deltaTime;
			this.currentTime = currentTime;
			this.game = game;
			this.keys = keys;
		}
	}

}
