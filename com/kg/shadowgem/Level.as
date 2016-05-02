package com.kg.shadowgem {
	import com.kg.obj.MovingObject;
	import flash.display.DisplayObject;
	import com.kg.obj.BoundedObject;
	import com.kg.obj.ObjectEmitter;
	import com.kg.state.UpdateEvent;
	import com.kg.obj.Camera;
	import flash.geom.Point;
	import com.kg.obj.GravityAffector;

	/**
	 * Defines a class that represents a level in the game.
	 * Each level controls its own physics, and at start, loads each of its children and sets them up.
	 */
	public class Level extends BoundedObject {

		/**
		 * The camera that is used to view the world.
		 */
		protected var camera: Camera;

		/**
		 * The gravity in the game.
		 */
		protected var gravity: GravityAffector;

		/**
		 * All of the floors in the game.
		 */
		protected var floors: Array;

		/**
		 * All of the walls in the game.
		 */
		protected var walls: Array;

		/**
		 * All of the pickups in the game.
		 */
		protected var pickups: Array;

		/**
		 * All of the crates in the game.
		 */
		protected var crates: Array;

		/**
		 * All of the misc objects in the game that do not belong to another group.
		 */
		protected var objects: Array;

		/**
		 * The player that exists in the game.
		 */
		protected var player: Player;

		/**
		 * All of the monsters that are in the level.
		 */
		protected var monsters: Array;

		/**
		 * All of the monster affectors in the level.
		 */
		protected var monsterAffectors: Array;

		/**
		 * All of the turrets in the level.
		 */
		protected var turrets: Array;

		/**
		 * The emitter that emits dirt particles from the player's feet.
		 */
		private var playerDirtEmitter: DirtEmitter;

		/**
		 * All of the exits in the level.
		 */
		protected var exits: Array;

		public function Level() {
		}

		public override function setup(): void {
			super.setup();
			floors = [];
			pickups = [];
			crates = [];
			objects = [];
			walls = [];
			monsters = [];
			monsterAffectors = [];
			exits = [];
			turrets = [];
			setupCamera();
			setupObjects();
			setupDirtEmitter();
			camera.setTarget(player);
			gravity = new GravityAffector();
			Sounds.loadLevel();
		}

		/**
		 * Sets up the dirt emitter for the player.
		 */
		private function setupDirtEmitter(): void {
			playerDirtEmitter = new DirtEmitter(player, new Point(0, player.height/2));
			camera.addContent(playerDirtEmitter);
		}

		/**
		 * Discovers and returns all of the bounded objects in this level.
		 * @return Array The array of BoundedObject entities that exist in this level.
		 */
		private function findObjects(): Array {
			var objects: Array = [];
			for(var i = 0; i < numChildren; i++) {
				var c:BoundedObject = getChildAt(i) as BoundedObject;
				if(c != null && c != camera) {
					objects.push(c);
				}
			}
			return objects;
		}

		/**
		 * Sets up the camera for the level.
		 */
		protected function setupCamera(): void {
			camera = new Camera(new Point(480, 270));
			addChild(camera);
			camera.setup();
		}

		/**
		 * Sets up the given object in the level.
		 * @param obj:BoundedObject The object that should be setup.
		 */
		protected function setupObject(obj: BoundedObject): void {
			removeChild(obj);
			camera.addContent(obj);
			obj.setup();
			if(obj is MetalFloor) {
				if(Math.abs(obj.rotation) < 45) {
					floors.push(obj);
				} else {
					walls.push(obj);
				}
			} else if(obj is Pickup) {
				pickups.push(obj);
			} else if(obj is Crate) {
				crates.push(obj);
			} else if(obj is Player) {
				player = Player(obj);
			} else if(obj is TurretMonster) {
				turrets.push(obj);
			} else if(obj is Monster) {
				monsters.push(obj);
			} else if(obj is MonsterAffector) {
				monsterAffectors.push(obj);
			} else if(obj is ExitDoor) {
				exits.push(obj);
			} else {
				objects.push(obj);
			}
		}

		protected function removeObjectFromDisplay(obj: BoundedObject): void {
			camera.removeContent(obj);
		}

		/**
		 * Sets up the objects in this level and adds them to this level's object list.
		 */
		protected function setupObjects(): void {
			var objs: Array = findObjects();
			for each(var obj: BoundedObject in objs) {
				setupObject(obj);
			}
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			camera.update(e);
			for each(var obj in objects) {
				obj.update(e);
			}
			gravity.affectObject(e, player);
			gravity.affectObjects(e, [playerDirtEmitter]);
			updateArray(e, objects);
			updateArray(e, floors);
			updateArray(e, walls);
			updateArray(e, crates);
			updateArray(e, pickups);
			updateArray(e, monsters);
			updateArray(e, monsterAffectors);
			updateArray(e, exits);
			updateArray(e, turrets);
			playerDirtEmitter.update(e);
			player.update(e);
			checkLevelCollisions(e);
			checkLoss(e);
			e.playerData.livesLeft = player.getHealth();
		}

		/**
		 * Checks the game state to see if the player lost and updates the game correspondingly.
		 * @param e:UpdateEvent The current frame update event.
		 */
		protected function checkLoss(e: UpdateEvent): void {
			if(player.isDead) {
				e.game.switchState(new StateLoss());
			}
		}

		/**
		 * Updates all of the objects in the given array.
		 * @param e:UpdateEvent The current frame update event.
		 * @param arr:Array The array of objects that should be updated.
		 */
		private function updateArray(e: UpdateEvent, arr: Array): void {
			for each(var obj: BoundedObject in arr) {
				obj.update(e);
				if(obj.isDead) {
					var i = arr.indexOf(obj);
					if(i >= 0) {
						arr.splice(i, 1);
					}
					obj.dispose();
					removeObjectFromDisplay(obj);
				}
			}
		}

		/**
		 * Checks for collisions in the level.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function checkLevelCollisions(e: UpdateEvent): void {
			checkCharacterCollisions(e, player);
			checkCollision(e, player, monsters);
			checkCollision(e, player, exits);
			checkCollision(e, player, turrets);
			for each(var monster: Monster in monsters) {
				checkCharacterCollisions(e, monster);
				var bullet = player.findBulletCollisions(monster);
				if(bullet != null && monster.hurt(1)) {
					bullet.isDead = true;
				}
			}
			for each(var turret: TurretMonster in turrets) {
				// TODO: Cleanup so that only one loop is needed.
				var b = turret.findBulletCollisions(player);
				if(b != null && player.hurt(1)) {
					camera.shake(0.5);
					b.isDead = true;
				} else {
					for each(var tBullet: Bullet in turret.bullets.objects) {
						checkBulletCollisions(e, tBullet);
					}
				}
			}
			for each(var monsterAffector in monsterAffectors) {
				checkCollision(e, monsterAffector, monsters);
			}
		}

		/**
		 * Checks for collisions between the given object and other opaque objects in the level.
		 * @param e:UpdateEvent The current frame update event.
		 * @param obj:MovingObject The object to check against the level.
		 */
		protected function checkObjectCollisions(e: UpdateEvent, obj: MovingObject): void {
			checkCollision(e, obj, crates);
			checkCollision(e, obj, floors);
			checkCollision(e, obj, walls);
			checkCollision(e, obj, objects);
		}

		/**
		 * Checks for collisions between the given bullet and other opaque objects in the level.
		 * @param e:UpdateEvent The current frame update event.
		 * @param obj:Bullet The bullet to check against the level.
		 */
		protected function checkBulletCollisions(e: UpdateEvent, obj: Bullet): void {
			checkCollision(e, obj, floors);
			checkCollision(e, obj, walls);
			checkCollision(e, obj, objects);
		}

		/**
		 * Checks the collisions between the given character and other objects in the level.
		 * @param e:UpdateEvent The current frame update event.
		 * @param character:Character The character to check for collisions.
		 */
		protected function checkCharacterCollisions(e: UpdateEvent, character: Character): void {
			var crate = checkCollision(e, character, crates);
			var floor = checkCollision(e, character, floors);
			var wall = checkCollision(e, character, walls);
			var pickup = checkCollision(e, character, pickups);
			var obj = checkCollision(e, character, objects);
			for each(var b: Bullet in character.bullets.objects) {
				checkBulletCollisions(e, b);
			}
		}

		/**
		 * Checks for a collision between the given first object and the list of objects.
		 * @param e:UpdateEvent      The current frame update event.
		 * @param first:MovingObject The first object that is colliding with the second. When it comes to fixing the overlap, this one is going to be moved.
		 * @param objects:Array 	   The array of objects that collisions should be checked against.
		 * @return Boolean           Whether the first object collided with one of the objects in the given array.
		 */
		protected function checkCollision(e: UpdateEvent, first: MovingObject, objects: Array): Boolean {
			var collision: Boolean = false;
			for each(var obj: BoundedObject in objects) {
				if(first.collidesWith(obj)) {
					applyCollision(e, first, obj);
					collision = true;
				}
			}
			return collision;
		}

		/**
		 * Applies the affects of a collision between the first object and the second one.
		 * @param e:UpdateEvent       The current frame update event.
		 * @param first:MovingObject  The object that is colliding with the second.
		 * @param second:MovingObject The object that the first is colliding with.
		 */
		protected function applyCollision(e: UpdateEvent, first: MovingObject, second: BoundedObject): void {
			var dir: Point = second.getOverlapFix(first);
			if(first is Character) {
				applyCharacterCollision(e, dir, Character(first), second);
			} else if(first is MonsterAffector && second is Monster) {
				applyMonsterAffectorCollision(e, MonsterAffector(first), Monster(second));
			} else if(first is Bullet) {
				applyBulletCollision(e, dir, Bullet(first), second);
			}
		}

		/**
		 * Applies the effects of a collision between a monster and a monster affector.
		 * @param e:UpdateEvent										 The current frame update event.
		 * @param monsterAffector:MonsterAffector  The monster affector.
		 * @param monster:Monster									 The monster.
		 */
		protected function applyMonsterAffectorCollision(e: UpdateEvent, monsterAffector: MonsterAffector, monster: Monster): void {
			monsterAffector.affectMonster(e, monster);
		}

		/**
		 * Applies the affects of a collision between a character and some other object.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the player needs to move in to fix the overlap.
		 * @param character:Character The player that is colliding with something.
		 * @param second:BoundedObject The object that the player is colliding with.
		 */
		protected function applyCharacterCollision(e: UpdateEvent, dir: Point, character: Character, second: BoundedObject): void {
				var unaffectedVelocity = character.velocity.clone();
				if(second is Pickup) {
					if(character is Player) {
						applyPlayerPickupCollision(e, dir, Player(character), Pickup(second));
					}
			  } else if(character is Player && second is Monster) {
					applyPlayerMonsterCollision(e, dir, Player(character), Monster(second));
				} else if(character is Player && second is ExitDoor) {
					applyPlayerExitCollision(e, dir, Player(character), ExitDoor(second));
				} else {
					if(second is Crate) {
						applyCharacterCrateCollision(e, dir, character, Crate(second));
						// Only apply the collision if the player is moving down or the fix is down.
					} else if(character.velocity.y >= 0 || dir.y > 0 || Math.abs(dir.x) > 0) {
						applyNormalCollision(e, dir, character, second);
					}
				}
		}

		/**
		 * Applies the affects of a collision between the player and an exit door.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point     The direction that the player needs to move in to fix the overlap.
		 * @param player:Player The player that is colliding with the door.
		 * @param exit:ExitDoor The door that the player is colliding with.
		 */
		protected function applyPlayerExitCollision(e: UpdateEvent, dir: Point, player: Player, exit: ExitDoor): void {
			isDead = true;
		}

		/**
		 * Applies the affects of a collision between a player and a pickupable item.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the player needs to move in to fix the overlap.
		 * @param player:Player The player that is colliding with the gem.
		 * @param pickup:Pickup The pickup that the player is colliding with.
		 */
		protected function applyPlayerPickupCollision(e: UpdateEvent, dir: Point, player: Player, pickup: Pickup): void {
			if(pickup is Gem) {
				collectGem(e, Gem(pickup));
			} else if(pickup is Ammo) {
				collectAmmo(e, Ammo(pickup));
			}
			var i: int = pickups.indexOf(pickup);
			if(i >= 0) {
				pickups.splice(i, 1);
			}
			removeObjectFromDisplay(pickup);
		}

		/**
		 * Applies the affects of a collision between a character and a crate.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the character needs to move in to fix the overlap.
		 * @param character:Character The character that is colliding with the crate.
		 * @param crate:Crate The crate that the player is colliding with.
		 */
		protected function applyCharacterCrateCollision(e: UpdateEvent, dir: Point, character: Character, crate: Crate): void {
			// only apply the collision if the character is landing on the crate.
			if(dir.y < 0 && character.velocity.y > 0) {
				applyNormalCollision(e, dir, character, crate);
			}
		}

		/**
		 * Applies the affects of a collision between a player and a monster.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the player needs to move in to fix the overlap.
		 * @param player:Player The player that is colliding with the crate.
		 * @param monster:Monster The monster that the player is colliding with.
		 */
		protected function applyPlayerMonsterCollision(e: UpdateEvent, dir: Point, player: Player, monster: Monster): void {
			if(monster is TurretMonster) {
				TurretMonster(monster).shouldFire = true;
			} else if(monster.explosion == null) {
				if(player.hurt(monster.damage)) {
					camera.shake(0.5);
				}
			}
		}

		/**
		 * Applies the affects of a collision between two objects.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the first object needs to move in to fix the overlap.
		 * @param first:MovingObject The object that is colliding with the second.
		 * @param second:MovingObject The object that is being collided with.
		 */
		protected function applyNormalCollision(e: UpdateEvent, dir: Point, first: MovingObject, second: BoundedObject): void {
			if(dir.x != 0) {
				first.velocity.x = 0;
			}
			if(dir.y != 0) {
				if(first is Character) {
					Character(first).isGrounded = true;
				}
				first.velocity.y = 0;
			}
			first.x += dir.x;
			first.y += dir.y;
		}

		/**
		 * Applies the affects of a collision between a bullet and another object in the game.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the bullet needs to move in to fix the overlap.
		 * @param bullet:Bullet The object that is colliding with the second.
		 * @param second:MovingObject The object that is being collided with.
		 */
		protected function applyBulletCollision(e: UpdateEvent, dir: Point, bullet: Bullet, second: BoundedObject): void {
			bullet.isDead = true;
		}

		/**
		 * Collects the given gem and adds it to the player's score.
		 * @param e:UpdateEvent The current frame update event.
		 * @param gem:Gem The gem that should be collected.
		 */
		protected function collectGem(e: UpdateEvent, gem: Gem): void {
			Sounds.pickupGem();
			e.playerData.score += gem.worth;
		}

		/**
		 * Collects the given ammo and adds it to the player's ammo.
		 * @param e:UpdateEvent The current frame update event.
		 * @param ammo:Gem The ammo that should be collected.
		 */
		protected function collectAmmo(e: UpdateEvent, ammo: Ammo): void {
			Sounds.pickupAmmo();
			ShadowGemPlayerData(e.playerData).ammo += ammo.amount;
		}

	}

}
