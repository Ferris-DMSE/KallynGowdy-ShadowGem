package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Defines a class that represents objects with colliders that are in the shape of a circle.
	 */
	public class CircleCollider extends MovieClip implements ICollider {

		/**
		 * The radius of the collider.
		 */
		protected var radius:Number;

    /**
		 * Whether the Collider obeys collisions.
		 */
		public var colliderEnabled: Boolean = true;

		/**
		 * Creates a new circle collider.
		 * @param radius:Number The radius that should be used to evaluate collisions. If the number is less than or
		 * 						equal to zero, then the width of the object will be used.
		 */
		public function CircleCollider(radius:Number = 0) {
				updateRadius(radius);
		}

		/**
		 * Finds the first collision between this object and the given array of colliders. Returns the collider that
		 * this collider intersects with. If no collision is found, then null is returned.
		 * @param colliders:Array An array of CircleCollider objects that a collision should be found in.
		 */
		public function findCollision(colliders: Array): CircleCollider {
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
	  * Updates this collider's radius to match the object's width.
		* @param radius:Number The radius that should be used to evaluate collisions.
		*/
		protected function updateRadius(radius:Number = 0): void {
			this.radius = radius > 0 ? radius : (width / 2);
		}

		/**
		 * Determines if this collider collides with the given other collider.
		 * @param other:CircleCollider The other collider to check for collision with.
		 */
		public function collidesWith(other: CircleCollider): Boolean {
			var radii = other.radius + this.radius;
			return colliderEnabled && other.colliderEnabled && isWithinDistance(new Point(other.x, other.y), radii);
		}

		/**
		 * Determines if the given arbitrary point is within the given arbitrary distance of this object's center.
		 * @param p:Point The point to check the distance to.
		 * @param dist: Number The distance to check against.
		 */
		public function isWithinDistance(p: Point, dist: Number): Boolean {
			var dx:Number = p.x - this.x;
			var dy:Number = p.y - this.y;

			var sqrDist = (dx * dx) + (dy * dy);
			var sqrRadii = dist * dist;

			return sqrDist <= sqrRadii;
		}
	}

}
