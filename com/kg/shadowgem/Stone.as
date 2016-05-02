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
			return new Point(x - 25, y - 25);
		}

		protected override function findColliderSize(): Point {
			return new Point(50, 50);
		}

		public override function setup(): void {
			super.setup();
			boundless();
			velocity = new Point(0, 0);
		}

	}

}
