package com.kg.obj {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class for an object that represents an explosion.
	 */
	public class ExplosionObject extends MovingObject {

    /**
		 * The amount of time that the object can live for.
		 */
		public var lifetime: Number;

		/**
		 * The time that the dot should be killed.
		 */
		private var deathTime: Number = -1;

		/**
		 * Creates a new Explosion object with a random velocity.
		 */
		public function ExplosionObject() {
			var vX = Math.random() * 10 - 5;
			var vY = Math.random() * 10 - 5;
			velocity = new Point(vX, vY);
			lifetime = Math.random() * 2 * 1000;
		}

		/**
		 * Updates this Explosion object, moving it and checking its death status.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(deathTime < 0) {
				deathTime = e.currentTime + lifetime;
			}

			if(deathTime < e.currentTime) {
				isDead = true;
			}
		}
	}

}
