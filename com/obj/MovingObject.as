package com.kg.obj {
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines an abstract class that represents a dot that moves at a certian velocity.
	 */
	public class MovingObject extends BoundedObject {

		/**
		 * The velocity that this dot moves at.
		 * Represented by a Point object.
		 */
		public var velocity: Point;

		/**
		 * The rotational velocity that this object has.
		 * @default 0
		 */
		public var angularVelocity: Number;

    /**
		 * The explosion that this dot is currently simulating.
		 */
		public var explosion: Explosion;

		/**
		 * Creates a new Moving Dot Object.
		 */
		public function MovingObject() {
			super();
		}

		/**
		 * Runs any configuration that the dot needs before the first update
		 * frame, but after the dot is added to the view tree.
		 */
		public override function setup() : void {
			super.setup();
			angularVelocity = 0;
		}

		/**
		 * Sets the bottom of this object equal to the given Y position.
		 * @param Y:Number The new Y-Axis position of this object.
		 */
		public function setBottom(Y: Number): void {
			var currentY: Number;
			if(collider != null) {
				currentY = collider.getBottom();
			} else {
				currentY = y;
			}

			var deltaY = Y - currentY;
			y += deltaY;
		}

		/**
		 * Updates the Dot's position based on it's velocity.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(explosion == null) {
				updatePosition(e);
				updateRotation(e);
			}
			else {
				explosion.update(e);
				isDead = explosion.isDead;
			}
		}

		/**
		 * Updates the dot's position based on the velocity.
		 * @param e:UpdateEvent The current frame update event.
		 */
		private function updatePosition(e: UpdateEvent): void {
			velocity = findNewVelocity(e);
			y += velocity.y * e.deltaTime;
			x += velocity.x * e.deltaTime;
		}

		/**
		 * Updates the object's rotation based on the angular rotation.
		 * @param e:UpdateEvent The current frame update event.
		 */
		protected function updateRotation(e: UpdateEvent): void {
			rotation += angularVelocity * e.deltaTime;
		}

		/**
		 * Calculates the object's new velocity for the frame given the corresponding update event and returns a new point that represents the velocity for that time.
		 * Not required to be implemented, but can be used to calculate things such as drag.
		 * @return Point Returns a point that represents the object's new 2D velocity.
		 */
		protected function findNewVelocity(e: UpdateEvent): Point {
			if(velocity == null) {
				return new Point(0, 0);
			}
			return velocity;
		}

    /**
		 * Kills this dot and makes the death look like a small explosion.
		 */
		public function explode(): void {
			if(explosion == null) {
				gotoAndStop(3);
				explosion = createExplosion();
				addChild(explosion);
				explosion.setup();
				isDead = false;
			}
		}

		protected function createExplosion(): Explosion {
			return new Explosion();
		}
	}

}
