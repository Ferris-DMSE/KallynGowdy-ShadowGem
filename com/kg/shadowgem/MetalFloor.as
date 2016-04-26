package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a floor.
	 */
	public class MetalFloor extends RectangularObject {

		public function MetalFloor() {
			super();
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		protected override function findNewVelocity(e: UpdateEvent): Point {
			return new Point(0, 0);
		}
	}

}
