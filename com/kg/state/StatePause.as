package com.kg.state {

	import flash.display.MovieClip;
	import flash.ui.Keyboard;

		/**
		 * Defines an abtract class that represents a state and contains all of the shared logic for the states.
		 */
	public class StatePause extends State {

		/**
		 * The state that is currently paused.
		 */
    public var pausedState: State;

		/**
		 * Whether this state is paused.
		 */
		protected var paused: Boolean = true;

		/**
		 * Creates a new paused state that pauses the given state.
		 * @param stateToPause:State The state that should be paused while this state is active.
		 */
		public function StatePause(stateToPause: State) {
			this.pausedState = stateToPause;
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
			paused = true;
			stopAllClips(pausedState);
		}

		/**
		 * The core update function. This should be overridden to
		 * apply custom game logic to the game.
		 */
		protected override function updateCore(e: UpdateEvent): void {
			if(e.keys.onUp(Keyboard.ESCAPE)) {
				unpause();
			}
			checkUnpause(e);
		}

		/**
		 * Checks whether the state has been unpaused and acordingly switches the states back.
		 * @param e:UpdateEvent The current frame update event.
		 */
		protected function checkUnpause(e: UpdateEvent): void {
			if(!paused) {
				applyUnpause(e);
			}
		}

		/**
		 * Actually unpauses the game by switching the paused state to the active state.
		 * @param e:UpdateEvent The current frame update event.
		 */
		protected function applyUnpause(e: UpdateEvent): void {
			playAllClips(pausedState);
			e.game.swapState(pausedState);
		}

		/**
		 * Stops the animations on all of the children of the given movie clip.
		 * @param mc:MovieClip The movie clip that the animations should be stopped on.
		 */
		private function stopAllClips(mc:MovieClip):void {
    	visitAllClips(mc, stopClip);
		}

		/**
		 * Stops the given movie clip's animation(s).
		 * @param mc:MovieClip The movie clip.
		 */
		private function stopClip(mc: MovieClip): void {
			mc.stop();
		}

		/**
		 * Begins playing the given movie clip's animation(s).
		 * @param mc:MovieClip The movie clip.
		 */
		private function playClip(mc: MovieClip): void {
			mc.play();
		}

		/**
		 * Resumes the animations on all of the children of the given movie clip.
		 * @param mc:MovieClip The movie clip that the animations should be resumed on.
		 */
		private function playAllClips(mc: MovieClip): void {
			visitAllClips(mc, playClip);
		}

		/**
		 * Visits all of the movie clips that exist in the hierarchy of the given movie clip.
		 * @param mc:MovieClip The clip whose children should be visited.
		 * @param action:Function The action that should be run on each of the movie clips.
		 */
		private function visitAllClips(mc: MovieClip, action: Function): void {
			var n:int = mc.numChildren;
    	for (var i: int = 0; i < n; i++) {
        	var clip: MovieClip = mc.getChildAt(i) as MovieClip;
        	if (clip) {
							action(clip);
							visitAllClips(clip, action);
					}
    	}
		}

		/**
		 * Unpauses the game.
		 */
		public function unpause(): void {
			paused = false;
		}
	}

}
