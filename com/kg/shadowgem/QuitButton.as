package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.Button;
	import com.kg.state.UpdateEvent;
	import flash.display.DisplayObject;
	

	/**
	 * Defines a class that represents the quit button.
	 */
	public class QuitButton extends GemButton {

		public function QuitButton() {
		}

		protected override function animate(obj: DisplayObject): void {
      obj.x = Math.sin(counter * 3) * 5;
    }

		protected override function getNormalGem(): DisplayObject {
			return red;
		}

		protected override function getHoveredGem(): DisplayObject {
			return shadow;
		}
	}

}
