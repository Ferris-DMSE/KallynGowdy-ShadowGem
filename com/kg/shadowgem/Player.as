package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
	import flash.ui.Keyboard;

	/**
	 * Defines a class that represents the player.
	 */
	public class Player extends Character {

		public function Player() {
			// constructor code
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - 37.6 / 2);
		}

		protected override function findNewVelocity(e: UpdateEvent): Point {
			if(e.keys.isDown(Keyboard.RIGHT)) {
				velocity.x += acceleration * e.deltaTime;
			}
			else if(e.keys.isDown(Keyboard.LEFT)) {
				velocity.x -= acceleration * e.deltaTime;
			} else {
				// static friction
				velocity.x /= 1.25;
			}

			if(e.keys.onDown(Keyboard.SPACE)) {
				jump();
			}

			// rolling/dynamic friction
			velocity.x /= 1.05;
			return velocity;
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);

			if(currentFrame <= 81 && Math.abs(velocity.x) < 1) {
				gotoAndPlay("idle");
			} else if(currentFrame > 82 && Math.abs(velocity.x) > 1) {
				gotoAndPlay("moving");
			}
		}
	}

}
