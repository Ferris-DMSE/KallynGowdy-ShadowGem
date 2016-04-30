package com.kg.shadowgem {

  import com.kg.state.StatePause;
  import com.kg.state.UpdateEvent;
  import com.kg.state.State;
  import com.kg.state.GameManager;

		/**
		 * Defines an abtract class that represents a state and contains all of the shared logic for the states.
		 */
	public class StatePaused extends StatePause {

		/**
		 * Creates a new paused state that pauses the given state.
		 * @param stateToPause:State The state that should be paused while this state is active.
		 */
		public function StatePaused(stateToPause: State) {
			super(stateToPause);
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
      /*continueButton.setup();*/
		}

		/**
		 * The core update function. This should be overridden to
		 * apply custom game logic to the game.
		 */
		protected override function updateCore(e: UpdateEvent): void {
		    super.updateCore(e);
        if(continueButton.clicked) {
          unpause();
        }
        if(quitButton.clicked) {
          e.game.disposeState(pausedState);
          e.game.switchState(new StateTitle());
        }
        continueButton.update(e);
        quitButton.update(e);
		}

    public override function dispose(): void {
      super.dispose();
      continueButton.dispose();
      quitButton.dispose();
    }
	}

}
