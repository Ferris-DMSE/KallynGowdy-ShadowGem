package com.kg.state {

	import flash.display.MovieClip;
  import flash.events.Event;
  import flash.utils.getTimer;

		/**
		 * Defines an abtract class that represents a game manager.
		 */
	public class GameManager extends MovieClip {

    /**
     * The currently active state.
     */
    private var activeState: State;

    /**
     * The time that the last frame occured at.
     */
    private var lastFrameTime: Number = 0;

    /**
		 * The time that the current frame began at.
		 */
		private var currentFrameTime: Number = 0;

		/**
		 * The last calculated time difference between the last frame and the current frame.
		 */
		private var deltaTime: Number = 0;

		/**
		 * The calculated game time. This is determined to be the time as if it is only counted
		 * in steps of delta time. Counted in seconds.
		 */
		public var gameTime: Number = 0;

		/**
		 * The scale of time travel in the game.
		 * Negative values cause the game to travel in reverse.
		 * @default 1
		 */
		public var timeScale: Number = 1;

    /**
     * The amount of time (in milliseconds) that should be skipped for the next frame.
     */
    private var timeToSkipNextFrame: Number = 0;

    /**
     * The keyboard management object.
     */
    public var keys: Keys;

		/**
		 * Creates a new Game Manager object.
		 */
		public function GameManager() {
			addEventListener(Event.ENTER_FRAME, handleFrame);
      keys = new Keys(stage);
		}

    /**
     * Handles the ENTER_FRAME event.
     */
    private function handleFrame(e: Event): void {
      this.update(null);
    }

    /**
		 * Runs the update loop for the game.
		 * @param e:UpdateEvent Ignored.
		 */
		public function update(e:UpdateEvent): void {
			beforeUpdate();
			var e = getUpdateEvent();
      activeState.update(e);
			afterUpdate(e);
		}

    /**
		 * Runs any tasks that should be run before every state is updated for the frame.
		 */
		private function beforeUpdate(): void {
			processTime();
		}

		/**
		 * Runs any tasks that should be run after every state is updated for the frame.
		 * @param e:UpdateEvent The current frame update event.
		 */
		private function afterUpdate(e:UpdateEvent): void {
			keys.update();
			lastFrameTime = currentFrameTime;
		}

    /**
		 * Retrieves a new object that represents an update event for the game.
		 */
		private function getUpdateEvent(): UpdateEvent {
			return new UpdateEvent(deltaTime, gameTime, this, keys);
		}

    /**
     * Skips ahead the given amount of time during the next frame.
     * This intentionally skews delta time, which allows jumps in time to be reflected in the game.
     * @param milliseconds:Number The number of milliseconds that should be skipped.
     */
    public function skipTime(milliseconds: Number): void {
      timeToSkipNextFrame = milliseconds;
    }

    /**
		 * Calculates the time related properties for the frame.
		 */
		private function processTime(): void {
			currentFrameTime = getTimer() + timeToSkipNextFrame;
      timeToSkipNextFrame = 0;
			deltaTime = ((currentFrameTime - lastFrameTime) / 1000) * timeScale;
			gameTime += deltaTime;
		}

    /**
     * Switches the game to the given state.
     * @param newState:State The new state that the game should use.
     */
    public function switchState(newState: State): void {
      disposeState(activeState);
      activeState = newState;
      setupState(newState);
    }

		/**
		 * Switches the game to the given state without disposing of the previous state.
		 * @param newState:State The new state that the game should use.
		 */
		public function surroundState(newState: State): void {
			activeState = newState;
			setupState(newState);
		}

		/**
		 * Switches the game to the given state without resetting the given state.
		 * @param newState:State The new state that the game should use.
		 */
		public function swapState(newState: State): void {
			disposeState(activeState);
			activeState = newState;
		}

		/**
		 * Adds the state to the view tree and configures it.
		 * @param state:State The state that should be added.
		 */
		private function setupState(state: State): void {
			addChild(state);
			state.setup(this);
		}

    /**
     * Disposes of the given state and removes it from the view tree.
     * @param state:State The state that should be removed.
     */
    public function disposeState(state: State): void {
      if(state != null) {
        state.dispose();
        removeChild(state);
      }
    }
	}

}
