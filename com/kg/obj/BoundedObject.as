package com.kg.obj {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.kg.state.IUpdatable;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class for an object that is "bound" to the limits of the screen.
	 * When the object escapes the limits, it is marked as dead.
	 */
	public class BoundedObject extends MovieClip implements IUpdatable {

		/**
		 * The extra amount of padding to give the object off of the screen before it is marked as dead.
		 */
		public static const PADDING: Number = 15;

		/**
		 * The minimum X position that the object is allowed to reach before being marked as dead.
		 */
		protected var xMin: Number;

		/**
		 * The maximum X position that the object is allowed to reach before being marked as dead.
		 */
		protected var xMax: Number;

		/**
		 * The maximum Y position that the object is allowed to reach before being marked as dead.
		 */
		protected var yMax: Number;

		/**
		 * The minimum Y position that the object is allowed to occupy before being marked as dead.
		 */
		protected var yMin: Number;

		/**
		 * Whether the object should be considered "dead".
		 * That is, out of bounds and no longer useful.
		 */
		public var isDead: Boolean = false;

		/**
		 * The collider that is used to check for collisions with this object.
		 */
		public var collider: ICollider = null;

		/**
		 * Creates a new Bounded Object.
		 */
		public function BoundedObject() {
		}

		/**
		 * Configures the default X and Y minimum values.
		 */
		public function setup() : void {
			boundedToScreen();
		}

		/**
		 * Updates the bounds of this object to match the screen.
		 */
		protected function boundedToScreen(): void {
			xMin = -((width / 2) + PADDING);
			yMax = stage.stageHeight + (height / 2) + PADDING;
			xMax = stage.stageWidth + (width / 2) + PADDING;
			yMin = -(height / 2 + PADDING);
		}

		/**
		 * Updates the bounds of this object so that it will never be destroyed due to being out of bounds.
		 */
		protected function boundless(): void {
      xMin = int.MIN_VALUE;
      xMax = int.MAX_VALUE;
      yMin = int.MIN_VALUE;
      yMax = int.MAX_VALUE;
		}

		/**
		 * Checks this object's position against the boundaries.
		 */
		public function update(e: UpdateEvent): void {
			updateCollider(e);
			var absolutePosition = getAbsolutePosition();
			checkBoundaries(absolutePosition);
		}

		/**
		 * Gets the absolute position that this object is at. In laymans terms, this is the actual position
		 * that the object is placed on the screen at.
		 * @return Point The point, in pixels, that this object is at on the screen.
		 */
		protected function getAbsolutePosition(): Point {
			return this.localToGlobal(new Point());
		}

		/**
		 * Checks the position of the object against the configured boundaries.
		 * @param absolutePosition:Point The current absolute position that the object is at.
		 */
		protected function checkBoundaries(absolutePosition: Point): void {
			var X = absolutePosition.x;
			var Y = absolutePosition.y;
			if(X < xMin || Y > yMax || X > xMax || Y < yMin) {
				isDead = true;
			}
		}

		/**
		 * Finds the first collision between this object and the given array of objects. Returns the object that
		 * this object intersects with. If no collision is found, then null is returned.
		 * @param colliders:Array An array of BoundedObject objects that a collision should be found in.
		 * @return BoundedObject Returns the object from the given array that collides with this object.
		 */
		public function findCollision(colliders: Array): BoundedObject {
			if(collider != null) {
				for(var i = 0; i < colliders.length; i++) {
					var c: BoundedObject = colliders[i];
					if(collidesWith(c)) {
						return c;
					}
				}
			}
			return null;
		}

		/**
		 * Determines if this object collides with the given other object.
		 * @param other:BoundedObject The other collider to check for collision with.
		 * @return Boolean Whether this object collides with the given other object.
		 */
		public function collidesWith(other: BoundedObject): Boolean {
				return collider != null && other.collider != null && other != this && collider.collidesWith(other.collider);
		}

		/**
		 * Finds the vector that represents the distance this object needs to move in order to fix the overlap with
		 * the given other object.
		 * @param other:BoundedObject The other object that the overlap fix should be calculated for.
		 * @return Point The direction that this object needs to move in in order to fix the overlap.
		 */
		public function getOverlapFix(other: BoundedObject): Point {
			return collider.getOverlapFix(other.collider);
		}

		/**
		 * Updates the collider on this object.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function updateCollider(e: UpdateEvent): void {
		}

		/**
		 * Releases all unmanaged resources from this object.
		 */
		public function dispose(): void {
		}
	}

}
