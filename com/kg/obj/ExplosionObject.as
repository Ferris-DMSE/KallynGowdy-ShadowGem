package com.kg.obj {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class for an object that represents an explosion.
	 */
	public class ExplosionObject extends MovingObject {

    /**
		 * The amount of time, in seconds, that the object has left.
		 */
		public var lifetime: Number;

		/**
		 * The amount of time, in seconds, that the object will live for.
		 */
		protected var startingLifetime: Number;

		/**
		 * Creates a new Explosion object with a random velocity.
		 */
		public function ExplosionObject() {
			var vX = Math.random() * 10 - 5;
			var vY = Math.random() * 10 - 5;
			velocity = new Point(vX, vY);
			startingLifetime = Math.random() * 2;
			lifetime = startingLifetime;
		}

		/**
		 * Updates this Explosion object, moving it and checking its death status.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public override function update(e: UpdateEvent): void {
			super.update(e);
			lifetime -= e.deltaTime;
			if(lifetime < 0) {
				isDead = true;
			}
		}
	}

}
