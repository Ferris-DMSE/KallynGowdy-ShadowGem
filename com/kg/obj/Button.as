package com.kg.obj {

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import com.kg.state.UpdateEvent;

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
		 * Creates a new button.
		 */
		public function Button() {
			mouseChildren = false;
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, handleClick);
			addEventListener(MouseEvent.ROLL_OVER, handleMouseOver);
			addEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
		}

		/**
		 * Handles the click event on the button.
		 */
		private function handleClick(e: MouseEvent): void {
			clicked = true;
			if(clickSound != null) {
				clickSound.play();
			}
			stage.focus = stage;
		}

		/**
		 * Handles the ROLL_OVER event on the button.
		 */
		private function handleMouseOver(e: MouseEvent): void {
			hovering = true;
			if(hoverSound != null) {
				hoverSound.play();
			}
		}

		/**
		 * Handles the ROLL_OUT event on the button.
		 */
		private function handleMouseOut(e: MouseEvent): void {
			hovering = false;
		}

		/**
		 * Updates the button.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function update(e: UpdateEvent): void {
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
