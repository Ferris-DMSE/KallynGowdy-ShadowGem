package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Defines a class that represents objects with colliders that are in the shape of a rectangle.
	 */
	public class RectangleCollider implements ICollider {

		/**
		 * The size of the collider.
		 */
		protected var size:Point;

		/**
		 * The position that the rectangle's upper left corner is at.
		 */
		protected var position: Point;

    /**
		 * Whether the Collider obeys collisions.
		 */
		public var colliderEnabled: Boolean = true;

		/**
		 * The Y-Axis position of the top side of this rectangle.
		 */
    public var top: Number;

		/**
		 * The Y-Axis position of the bottom side of this rectangle.
		 */
    public var bottom: Number;

		/**
		 * The X-Axis position of the left side of this rectangle.
		 */
    public var left: Number;

		/**
		 * The X-Axis position of the right side of this rectangle.
		 */
    public var right: Number;

		public function getBottom(): Number {
			return bottom;
		}

		/**
		 * Creates a new rectangle collider using the given position and size.
		 * @param pos:Point The position that the rectangle's upper left corner is at.
		 * @param size:Point The size of the rectangle.
		 */
		public function RectangleCollider(pos: Point, size: Point) {
			this.position = pos;
			setSize(size);
		}

		/**
		 * Gets whether the collider is enabled.
		 * @return Boolean
		 */
		public function isEnabled(): Boolean {
			return colliderEnabled;
		}

		/**
		 * Sets whether the collider is enabled.
		 * @param isEnabled:Boolean Whether the collider should be enabled.
		 */
		public function setEnabled(isEnabled: Boolean): void {
			colliderEnabled = isEnabled;
		}

		/**
		 * Finds the first collision between this object and the given array of colliders. Returns the collider that
		 * this collider intersects with. If no collision is found, then null is returned.
		 * @param colliders:Array An array of RectangleCollider objects that a collision should be found in.
		 */
		public function findCollision(colliders: Array): ICollider {
			if(colliderEnabled) {
				for(var i:int = 0; i < colliders.length; i++) {
					var c = colliders[i];
					if(collidesWith(c)) {
						return c;
					}
				}
			}
			return null;
		}

   /**
	  * Updates this collider's size to match the given size.
		* @param size:Point The size that should be used to evaluate collisions.
		*/
		public function setSize(size: Point): void {
			this.size = size;
			recalculateSides();
		}

		/**
		 * Updates this collider's position.
		 * @param pos:Point The position that the collider should be evaluated at.
		 */
		public function setPosition(pos: Point): void {
			this.position = pos;
			recalculateSides();
		}

		private function recalculateSides(): void {
			top = position.y;
      bottom = position.y + size.y;
      right = position.x + size.x;
      left = position.x;
		}

		/**
		 * Determines if this collider collides with the given other collider.
		 * @param other:RectangleCollider The other collider to check for collision with.
		 */
		public function collidesWith(other: ICollider): Boolean {
			var rect: RectangleCollider = other as RectangleCollider;
			if(rect != null && isEnabled() && rect.isEnabled()) {
				if(left > rect.right) {
					return false;
				} else if(right < rect.left) {
					return false;
				} else if(bottom < rect.top) {
					return false;
				} else if(top > rect.bottom) {
					return false;
				}
				return true;
			}
			return false;
		}
	}

}
