package com.kg.obj {

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.media.Sound;

	/**
	 * Defines a generic button.
	 */
	public class Button extends MovieClip {

		private static const STATE_NORMAL: int = 1;
		private static const STATE_HOVER: int = 2;

		/**
		 * Whether this button was recently clicked.
		 */
		public var clicked:Boolean = false;

		/**
		 * Whether this button is being hovered over.
		 */
		public var hovering: Boolean = false;

		/**
		 * The audio that should be used for hover sound effects.
		 */
		public var hoverSound: Sound = null;

		/**
		 * The sound that should be used for when the button is clicked.
		 */
		public var clickSound: Sound = null;

		/**
		 * Creates a new button with the given text.
		 * @param text:String The text that should be shown on the button.
		 */
		public function Button(text: String = null) {
			if(text) {
				setText(text);
			}
			mouseChildren = false;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.ROLL_OVER, handleMouseOver);
			addEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
			gotoAndStop(STATE_NORMAL);
		}

		/**
		 * Changes the text displayed on this button to the given string of text.
		 * @param text:String The text that should be displayed on the button.
		 */
		public function setText(text: String) {
			btnText.text = text;
		}

		/**
		 * Handles the click event on the button.
		 */
		private function handleClick(e: MouseEvent): void {
			clicked = true;
			if(clickSound != null) {
				clickSound.play();
			}
		}

		/**
		 * Handles the ROLL_OVER event on the button.
		 */
		private function handleMouseOver(e: MouseEvent): void {
			hovering = true;
			gotoAndStop(STATE_HOVER);
			if(hoverSound != null) {
				hoverSound.play();
			}
		}

		/**
		 * Handles the ROLL_OUT event on the button.
		 */
		private function handleMouseOut(e: MouseEvent): void {
			hovering = false;
			gotoAndStop(STATE_NORMAL);
		}

		/**
		 * Updates the button.
		 */
		public function update(): void {
			clicked = false;
		}

		/**
		 * Cleans up all unmanaged resources used by this button.
		 */
		public function dispose(): void {
			removeEventListener(MouseEvent.CLICK, handleClick);
			removeEventListener(MouseEvent.ROLL_OVER, handleMouseOver);
			removeEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
		}

	}

}
