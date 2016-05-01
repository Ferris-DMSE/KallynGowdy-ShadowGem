package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.UpdateEvent;
	import flash.geom.Point;
	import com.kg.obj.MovingObject;

	/**
	 * Defines a class that represents a turret that is able to fire at the player.
	 */
	public class TurretMonster extends Monster {

		/**
		 * Whether the turrent should be firing.
		 */
		public var shouldFire: Boolean = false;

		public function TurretMonster() {
		}

		protected override function shouldShoot(e: UpdateEvent): Boolean {
			var absPos = getAbsolutePosition();
			return shouldFire && bullets.objects.length <= 0 && absPos.x >= 0 && absPos.y >= 0;
		}

		protected override function findColliderPosition(): Point {
			var dir = getFacingDirection();
			var X: Number;
			var Y: Number;
			if(dir.x < 0) {
				X = x + dir.x * 1000;
			} else {
				X = x;
			}
			if(dir.y < 0) {
				Y = y + dir.y * 1000;
			} else {
				Y = y;
			}
			return new Point(X, Y);
		}

		protected override function findColliderSize(): Point {
			var dir = getFacingDirection();
			// Facing more horizontal than vertical
			if(dir.x < 0) {
				return new Point(1400, height);
			} else { // facing more vertical than horizontal
				return new Point(height, 1400);
			}
		}

		protected override function createBullet(): MovingObject {
			return new Bullet(getFacingDirection());
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			shouldFire = false;
		}

		protected override function playShootSound(): void {
			Sounds.turretShoot();
		}
	}

}
