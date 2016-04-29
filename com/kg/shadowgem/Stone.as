package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;

	/**
	 * Defines a class that represents a stone that cannot be traversed.
	 */
	public class Stone extends RectangularObject {
		public function Stone() {
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		public override function setup(): void {
			super.setup();
			velocity = new Point(0, 0);
		}

	}

}
