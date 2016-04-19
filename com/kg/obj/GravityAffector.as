package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that can affect object velocities to obey gravity.
	 */
	public class GravityAffector extends ObjectAffector {

		/**
		 * The strength of gravity. Represented as the downward acceleration that is applied to the pirate
		 * in pixels per second. Ex. gravity = 400 means accelerate the pirate downward by 400 pixels every second.
		 * The default is 568.4 pixels per second downward, which is calculated because the pirate is 58 pixels tall.
		 * Equate 58 pixels to 1 meter, then gravity is 568.4, because 568.4 / 9.8 = 58.
		 * @default 568.4
		 */
		public var gravity: Number = 568.4;

		public function GravityAffector() {
		}

		public override function affectObject(e: UpdateEvent, obj: MovingObject): void {
			if(obj.velocity != null) {
				obj.velocity.y += gravity * e.deltaTime;
			}
		}
	}

}
