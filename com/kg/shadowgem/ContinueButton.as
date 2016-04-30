package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.Button;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents the continue button.
	 */
	public class ContinueButton extends Button {

		/**
		 * The timer that represents where the button is in it's animation.
		 */
		private var counter: Number = 0;

		public function ContinueButton() {
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(hovering) {
				green.alpha = 0;
				shadow.alpha = 1;
				shadow.y = 25 + Math.sin(counter * 5) * 5;
				green.y = shadow.y;
				counter += e.deltaTime;
			} else {
				green.alpha = 1;
				shadow.alpha = 0;
			}
		}
	}

}
