package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.ExplosionObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a piece of smoke from a gunshot.
	 */
	public class GunSmoke extends ExplosionObject {

		/**
		 * The normalized x-axis direction that the smoke should travel towards.
		 */
		private var direction: Number;

		/**
		 * Creates a new piece of gun smoke.
		 * @param xDir:Number The normalized x-axis direction that the smoke should travel towards.
		 */
		public function GunSmoke(xDir: Number) {
			direction = xDir;
		}

		public override function setup(): void {
			super.setup();
			velocity.x = Math.random() * direction * 100;
			velocity.y *= 10;
			setLifetime(0.2);
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			alpha = lifetime / startingLifetime;
		}
	}

}
