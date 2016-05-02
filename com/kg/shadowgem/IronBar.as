package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a piece of flooring that looks like an iron bar.
	 */
	public class IronBar extends RectangularObject {
		public function IronBar() {
		}

		public override function setup(): void {
			super.setup();
			boundless();
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		protected override function findNewVelocity(e: UpdateEvent): Point {
			return new Point(0, 0);
		}
	}
}
