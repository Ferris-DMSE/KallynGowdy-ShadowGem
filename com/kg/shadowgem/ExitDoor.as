package com.kg.shadowgem {

	import flash.display.MovieClip;
  import flash.geom.Point;
	import com.kg.obj.RectangularObject;

	/**
	 * Defines a class that represents a door that exists the level and returns the player to the level selection level.
	 */
	public class ExitDoor extends RectangularObject {

		public function ExitDoor() {
		}

		public override function setup(): void {
			super.setup();
			boundless();
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width * .5, y - height * .5);
		}
	}

}
