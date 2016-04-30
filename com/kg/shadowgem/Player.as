package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import com.kg.obj.MovingObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
	import flash.ui.Keyboard;
	import com.kg.obj.Explosion;

	/**
	 * Defines a class that represents the player.
	 */
	public class Player extends Character {

		public function Player() {
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - 37.6 / 2);
		}

		protected override function shouldMoveLeft(e: UpdateEvent): Boolean {
      return e.keys.isDown(Keyboard.LEFT) || e.keys.isDown(Keyboard.A);
    }

    protected override function shouldMoveRight(e: UpdateEvent): Boolean {
      return e.keys.isDown(Keyboard.RIGHT) || e.keys.isDown(Keyboard.D);
    }

    protected override function shouldJump(e: UpdateEvent): Boolean {
      return e.keys.onDown(Keyboard.SPACE);
    }

		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(currentFrame <= 81 && Math.abs(velocity.x) < 1) {
				gotoAndPlay("idle");
			} else if(currentFrame > 82 && Math.abs(velocity.x) > 1) {
				gotoAndPlay("moving");
			}

			if(velocity.x < 0) {
				// moving left, reflect player scale
				scaleX = -1;
			} else {
				// moving right, normal
				scaleX = 1;
			}
		}

		protected override function shouldShoot(e: UpdateEvent): Boolean {
			return e.keys.onDown(Keyboard.CONTROL);
		}

		protected override function createBullet(): MovingObject {
			return new Bullet(new Point(velocity.x, 0));
		}

		protected override function canShoot(e: UpdateEvent): Boolean {
			return ShadowGemPlayerData(e.playerData).ammo > 0 && super.canShoot(e);
		}

		protected override function createExplosion(): Explosion {
			var e: Explosion = new BoneExplosion();
			e.y = -10;
			return e;
		}
	}

}
