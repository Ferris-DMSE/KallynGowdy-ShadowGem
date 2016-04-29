package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.ExplosionObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a bone from a monster's death.
	 */
	public class MonsterDeathBone extends ExplosionObject {

		public function MonsterDeathBone() {
		}

		public override function setup(): void {
			super.setup();
			angularVelocity = Math.random() * 400 - 200;
			velocity.x *= 10;
			velocity.y *= 10;
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			alpha = lifetime / startingLifetime;
		}
	}

}
