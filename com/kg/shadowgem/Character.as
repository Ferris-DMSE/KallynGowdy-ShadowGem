package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import com.kg.obj.MovingObject;
	import com.kg.obj.BoundedObject;
	import com.kg.obj.SingleEmitter;
	import com.kg.obj.ExplosionEmitter;

	/**
	 * Defines a class that represents a character.
	 */
	public class Character extends RectangularObject {

		/**
		 * Whether the character is on the ground or not.
		 */
		public var isGrounded: Boolean = true;

    /**
     * The force, in pixels, that the character jumps at.
     */
    public var jumpForce: Number = 400;

    /**
     * The acceleration, in pixels per second, that the character moves at.
     */
    public var acceleration: Number = 500;

    /**
     * The amount of friction that is applied when the character is not actively moving.
     * Expressed as the factor of slowdown per frame.
     * @default 1.25
     */
    public var staticFriction: Number = 1.25;

    /**
     * The amount of friction that is applied when the character is actively moving/accelerating.
     * Expressed as the factor of slowdown per frame.
     * @default 1.05
     */
    public var dynamicFriction: Number = 1.05;

		/**
		 * The amount of health that this character has.
		 * @default 3
		 */
		public var health: int = 3;

		/**
		 * The amount of time in seconds that this character is immune to damage after being hit.
		 * @default 3
		 */
		public var damageShieldLength: Number = 3;

		/**
		 * The amount of time left on the character's damage shield.
		 */
		private var damageShieldLeft: Number;

		/**
		 * The amount of ammo that the character has left.
		 */
		public var ammo: int = int.MAX_VALUE;

		/**
		 * The bullets that this character has shot.
		 */
		protected var bullets: SingleEmitter;

		/**
		 * The emitter that can emit the gun smoke for the bullets.
		 */
		private var gunSmoke: ExplosionEmitter;

		/**
		 * The number of seconds between gunshots.
		 */
		public var gunCooldown: Number = 1;

		/**
		 * The amount of time left for the gun to cooldown.
		 */
		private var gunCooldownLeft: Number = 0;

		public function Character() {
		}

		public override function setup(): void {
			super.setup();
			boundless();
			damageShieldLeft = -1;
			velocity = new Point(0, 0);
			bullets = new SingleEmitter();
			parent.addChild(bullets);
			gunSmoke = new ExplosionEmitter(createGunSmokeExplosion);
			parent.addChild(gunSmoke);
		}

		protected function createGunSmokeExplosion(): GunSmokeExplosion {
			// TODO:
			return new GunSmokeExplosion(velocity.x/Math.abs(velocity.x));
		}

    protected override function findNewVelocity(e: UpdateEvent): Point {
      if(shouldMoveRight(e)) {
				velocity.x += acceleration * e.deltaTime;
			}
			else if(shouldMoveLeft(e)) {
				velocity.x -= acceleration * e.deltaTime;
			} else {
				// static friction
				velocity.x /= staticFriction;
			}

			if(shouldJump(e)) {
				jump();
			}

			// rolling/dynamic friction
			velocity.x /= dynamicFriction;
			return velocity;
    }

    /**
     * Determines whether the character should move left during the frame.
     * @param e:UpdateEvent The current frame update event.
     * @return Boolean Whether the character should move left.
     */
    protected function shouldMoveLeft(e: UpdateEvent): Boolean {
      return false;
    }

    /**
     * Determines whether the character should move right during the frame.
     * @param e:UpdateEvent The current frame update event.
     * @return Boolean Whether the character should move right.
     */
    protected function shouldMoveRight(e: UpdateEvent): Boolean {
      return false;
    }

    /**
     * Determines whether the character should begin jumping during the frame.
     * @param e:UpdateEvent The current frame update event.
     * @return Boolean Whether the character should jump.
     */
    protected function shouldJump(e: UpdateEvent): Boolean {
      return false;
    }

		/**
		 * Determines whether the character should shoot.
		 * @param e:UpdateEvent The current frame update event.
		 * @return Boolean Whether the character should shoot during the frame.
		 */
		protected function shouldShoot(e: UpdateEvent): Boolean {
			return false;
		}

		/**
		 * Determines if the character can shoot.
		 * @param e:UpdateEvent The current frame update event.
		 * @return Boolean Whether the character can shoot.
		 */
		protected function canShoot(e: UpdateEvent): Boolean {
			return ammo > 0 && gunCooldownLeft <= 0;
		}

    /**
     * Finds the acceleration that should be applied to the character for the frame.
     * @param e:UpdateEvent The current frame update event.
     * @return Point The Point that represents the acceleration that should be applied
     */
    protected function findAcceleration(e: UpdateEvent): Point {
        return new Point(0, 0);
    }

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - 37.6 / 2);
		}

    /**
     * Makes the character jump.
     */
    public function jump(): void {
      if(isGrounded) {
				velocity.y -= jumpForce;
			}
    }

		/**
		 * Makes the character shoot a bullet.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function shoot(e: UpdateEvent): void {
			if(canShoot(e)) {
				gunCooldownLeft = gunCooldown;
				ammo--;
				var bullet: MovingObject = createBullet();
				bullets.emitGivenObject(bullet, new Point(x, y));
				var dir: Point = getFacingDirection();
				gunSmoke.emitExplosion(new Point(x + dir.x * 15, y + dir.y - 10));
			}
		}

		/**
		 * Gets the normalized vector that this character is facing in.
		 * @return Point The Direction that the character is facing.
		 */
		public function getFacingDirection(): Point {
			var rotation: Number = rotation * Math.PI/180;
			if(scaleX < 0) {
				rotation += Math.PI / 2;
			}
			var dir: Point = new Point(Math.cos(rotation), Math.sin(rotation));
			return dir;
		}

		/**
		 * Gets whether the character faces right by default.
		 * Used to determine whether the shooting directions need to be flipped for the character.
		 * @return Boolean Returns true if the character faces right by default. Otherwise false.
		 */
		protected function facesRightByDefault(): Boolean {
			return true;
		}

		/**
		 * Creates a new bullet for the character to shoot.
		 */
		protected function createBullet(): MovingObject {
			throw new Error("createBullet() needs to be implemented in order to shoot.");
		}

		/**
		 * Damages the player and returns whether the player was damaged.
		 * @param amount:int The amount of damage that is applied to the character's health.
		 * @return Boolean Whether the player was damaged.
		 */
		public function hurt(amount: int): Boolean {
			if(damageShieldLeft <= 0 && !hasNoHealth()) {
				health -= amount;
				if(hasNoHealth()) {
					explode();
				} else {
					damageShieldLeft = damageShieldLength;
				}
				return true;
			}
			return false;
		}

		/**
		 * Determines whether the player's health has run out.
		 * @return Boolean Whether the player's health is out.
		 */
		private function hasNoHealth(): Boolean {
			return health <= 0;
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			damageShieldLeft -= e.deltaTime;
			flashDamage();
			if(shouldShoot(e)) {
				shoot(e);
			}
			bullets.update(e);
			gunSmoke.update(e);
			gunCooldownLeft -= e.deltaTime;
		}

		/**
		 * Causes the character's color to flash white while the damage shield is active.
		 */
		protected function flashDamage(): void {
			var trans: ColorTransform = new ColorTransform();
			if(damageShieldLeft > 0 &&  int(damageShieldLeft * 2 - 1) % 2 == 0) {
				trans.color = 0xFFFFFF;
			}
			this.transform.colorTransform = trans;
		}

		/**
		 * Checks for bullet collisions with the given object and returns the bullet that collided.
		 * @param obj:BoundedObject The object to check for collisions with a bullet that this character shot.
		 * @return MovingObject The bullet that hit the given object. Null if no collision was detected.
		 */
		public function findBulletCollisions(obj: BoundedObject): MovingObject {
			return MovingObject(bullets.checkCollisions(obj));
		}

		public override function dispose(): void {
			super.dispose();
			parent.removeChild(bullets);
			parent.removeChild(gunSmoke);
		}
	}

}
