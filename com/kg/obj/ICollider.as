package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Defines a class that represents objects with colliders that are in the shape of a rectangle.
	 */
	public interface ICollider {

		/**
		 * Sets whether the collider is enabled.
		 * @param isEnabled:Boolean Whether the collider should be enabled.
		 */
		function setEnabled(isEnabled: Boolean): void;

    /**
     * Gets whether the collider is currently enabled.
		 * @return Boolean
     */
    function isEnabled(): Boolean;

		/**
		 * Finds the first collision between this object and the given array of colliders. Returns the collider that
		 * this collider intersects with. If no collision is found, then null is returned.
		 * @param colliders:Array An array of ICollider objects that a collision should be found in.
		 * @return ICollider
		 */
		function findCollision(colliders: Array): ICollider;

		/**
		 * Determines if this collider collides with the given other collider.
		 * @param other:ICollider The other collider to check for collision with.
		 * @return Boolean
		 */
		function collidesWith(other: ICollider): Boolean;

		/**
		 * Gets the Y-Axis coordinate of the bottom of this collider.
		 * @return Number
		 */
		function getBottom(): Number;

    /**
     * Gets the vector that represents the direction that this collider will have to move
     * in in order to not overlap with the given other collider.
     * @param other:ICollider The other collider to fix the overlap with.
     * @return Point The direction that this collider should move in.
     */
    function getOverlapFix(other: ICollider): Point;
	}
}
