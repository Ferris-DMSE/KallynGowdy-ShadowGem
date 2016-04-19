package com.kg.state {

	import flash.display.MovieClip;

		/**
		 * Defines an abtract class that represents a state and contains all of the shared logic for the states.
		 */
	public class State extends MovieClip implements IUpdatable {

		/**
		 * The time that the state was activated on.
		 */
		public var activateTime: Number = 0;

		/**
		 * The calculated state time. This is essentially the same as game time, but it
		 * is calculated from the perspective of the current state.
		 */
		public var stateTime: Number = 0;

		/**
		 * Creates a new State object.
		 */
		public function State() {
			// constructor code
		}

		/**
		 * Runs the update event loop on the state.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function update(e: UpdateEvent): void {
			var gameTime = e.currentTime;
			e.currentTime = stateTime;
			updateCore(e);
			stateTime += e.deltaTime;
			e.currentTime = gameTime;
		}

		/**
		 * The core update function. This should be overridden to
		 * apply custom game logic to the game.
		 */
		protected function updateCore(e: UpdateEvent): void {

		}

		/**
		 * Runs any pre-start post-addChild tasks that are required for the playing state.
		 * @param game:GameManager The game manager for the game.
		 */
		public function setup(game: GameManager): void {
			activateTime = game.gameTime;
			stateTime = 0;
		}

		/**
		 * Releases any unmanaged resources from the state.
		 */
		public function dispose(): void {

		}
	}

}
