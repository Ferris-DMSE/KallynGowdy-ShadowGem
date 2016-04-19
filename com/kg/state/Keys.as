package com.kg.state {

	import flash.display.Stage;
  import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

		/**
		 * Defines a class that represents the state of keys for a frame.
		 */
	public class Keys {

		private static const KONAMI_CODE: Array = [
			Keyboard.UP,
			Keyboard.UP,
			Keyboard.DOWN,
			Keyboard.DOWN,
			Keyboard.LEFT,
			Keyboard.RIGHT,
			Keyboard.LEFT,
			Keyboard.RIGHT,
			Keyboard.B,
			Keyboard.A
		];

		/**
		 * The position that the player is at in the konami code.
		 */
		private var konamiPos: int = 0;

    /**
     * The stage that this object listens to key events on.
     */
    private var stage: Stage;

    private var keys: Array = new Array();
    private var previousKeys: Array = new Array();

		/**
		 * Creates a new Keys object.
     * @param stage:Stage The stage that this object should listen to events on.
		 */
		public function Keys(stage: Stage) {
      this.stage = stage;
      stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
		}

    /**
     * Cleans up and releases all unmanaged resources used by this object.
     */
    public function dispose(): void {
      stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
      stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
    }

    /**
		 * Runs the update event loop on the keys.
		 */
    public function update(): void {
			previousKeys = keys.concat();
		}

    /**
     * Handles the KeyboardEvent.KEY_UP event.
     */
    private function handleKeyUp(e: KeyboardEvent): void {
      handleKey(e.keyCode, false);
    }

    /**
     * Handles the KeyboardEvent.KEY_DOWN event.
     */
    private function handleKeyDown(e: KeyboardEvent): void {
      handleKey(e.keyCode, true);
			if(!onKonamiKey()) {
				konamiPos = 0;
			}
    }

    /**
     * Handles the logic for a key based on whether it is currently pressed or not.
     * @param keyCode:int The code of the key that was pressed or released.
     * @param pressed:Boolean Whether the key was just pressed or just released.
     */
    private function handleKey(keyCode: int, pressed: Boolean): void {
			keys[keyCode] = pressed;
		}

    /**
		 * Gets whether the given key code is currently pressed.
		 * @param keyCode:int The code of the key whose state should be checked.
		 * @return Boolean Whether the key is currently pressed.
		 */
		public function isDown(keyCode: int): Boolean {
			return keys[keyCode];
		}

		/**
		 * Gets whether the given key code is not currently pressed.
		 * @param keyCode:int The code of the key whose state should be checked.
		 * @return Boolean Whether the key is not currently pressed.
		 */
		public function isUp(keyCode: int): Boolean {
			return !isDown(keyCode);
		}

    /**
		 * Gets whether the given key code was just released.
		 * @param keyCode:int The code of the key whose state should be checked.
		 * @return Boolean Whether the key was just released.
		 */
		public function onUp(keyCode: int): Boolean {
			return !keys[keyCode] && previousKeys[keyCode];
		}

		/**
		 * Gets whether the given key code was just pressed.
		 * @param keyCode:int The code of the key whose state should be checked.
		 * @return Boolean Whether the key was just pressed.
		 */
		public function onDown(keyCode: int): Boolean {
			return keys[keyCode] && !previousKeys[keyCode];
		}

		/**
		 * Gets whether the next key in the konami code was pressed.
		 * @return Boolean Whether the next konami code key was pressed.
		 */
		public function onKonamiKey(): Boolean {
			return onDown(Keys.KONAMI_CODE[konamiPos]);
		}

		/**
		 * Moves the current konami code position up one. Returns true
		 * if the konami code was completed, otherwise false.
		 * @return Boolean
		 */
		public function advanceKonamiPosition(): Boolean {
			konamiPos++;
			return hasCompletedKonamiCode();
		}

		/**
		 * Determines whether the current konami position reflects that the user has completed the konami code.
		 * @return Boolean
		 */
		public function hasCompletedKonamiCode(): Boolean {
			return konamiPos >= Keys.KONAMI_CODE.length;
		}

		/**
		 * Resets the current konami position.
		 */
		public function resetKonamiPosition(): void {
			konamiPos = 0;
		}

		/**
		 * Gets the current konami position.
		 */
		public function getKonamiPosition(): int {
			return konamiPos;
		}
	}

}
