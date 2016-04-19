package com.kg.obj {

	import com.kg.state.UpdateEvent;
	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * Defines a class that an object that has a rectangle collider.
	 */
	public class RectangularObject extends MovingObject {

		public function RectangularObject() {
			super();
		}

		public override function setup(): void {
			super.setup();
			collider = new RectangleCollider(findColliderPosition(), findColliderSize());
    }

		/**
		 * Finds the collider's current position.
		 * @return Point The position that the collider should be at for the frame.
		 */
		protected function findColliderPosition(): Point {
			return new Point(x, y);
		}

		/**
		 * Finds the collider's current size.
		 * @return Point the size that the collider should be at for the lifetime of the object.
		 */
		protected function findColliderSize(): Point {
			return new Point(width, height);
		}

		public override function update(e: UpdateEvent): void {
			RectangleCollider(collider).setPosition(findColliderPosition());
			super.update(e);
		}

	}

}
