package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;

	/**
	 * Defines a crate that exists in the game as an obstacle.
	 */
	public class Crate extends RectangularObject {

		public function Crate() {
			super();
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		public override function setup(): void {
			super.setup();
			boundless();
			velocity = new Point(0, 0);
		}
	}

}
