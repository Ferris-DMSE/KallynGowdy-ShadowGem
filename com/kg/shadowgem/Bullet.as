package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a bullet.
	 */
	public class Bullet extends RectangularObject {

		/**
		 * The direction that the bullet travels in.
		 */
		private var direction: Point;

		/**
		 * The speed that this bullet travels at.
		 */
		public var speed: Number = 200;

		/**
		 * The acceleration that the bullet experiences during it's lifetime.
		 */
		public var acceleration: Number = 200;

		/**
		 * Creates a new bullet.
		 * @param dir:Point The direction that the bullet should travel in.
		 */
		public function Bullet(dir: Point) {
			direction = dir.clone();
			var mag: Number = Math.sqrt(direction.x * direction.x + direction.y * direction.y);
			direction.x /= mag;
			direction.y /= mag;
		}

		public override function setup(): void {
			super.setup();
			velocity = new Point(direction.x * speed, direction.y * speed);
			x += direction.x * 25;
			y += direction.y * 25;
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		protected override function findNewVelocity(e: UpdateEvent): Point {
			return new Point(velocity.x + acceleration * direction.x * e.deltaTime, velocity.y);
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(velocity.x < 0) {
				scaleX = -1;
			} else {
				scaleX = 1;
			}

			if(Math.abs(velocity.y) > Math.abs(velocity.x)) {
				rotation = 90;
			} else {
				rotation = 0;
			}
		}
	}

}
