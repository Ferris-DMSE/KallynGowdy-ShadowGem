package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.obj.Explosion;
  import com.kg.obj.BoundedObject;

	/**
	 * Defines a class that represents an explosion of gun smoke.
	 */
	public class GunSmokeExplosion extends Explosion {

		/**
		 * The general direction that the gun smoke should be fired in.
		 */
		private var direction: Number;

		/**
		 * Creates a new gun smoke explosion.
		 * @param xDir:Number The normalized x-axis direction that the smoke should travel towards.
		 */
		public function GunSmokeExplosion(xDir: Number) {
      super();
			direction = xDir;
      objectCount = 6;
		}

    protected override function createObject(): BoundedObject {
			return new GunSmoke(direction);
		}
	}

}
