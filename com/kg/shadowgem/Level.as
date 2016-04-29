package com.kg.shadowgem {
	import com.kg.obj.MovingObject;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObject;
	import com.kg.obj.BoundedObject;
	import com.kg.obj.ObjectEmitter;
	import Box2D.Common.Math.b2Vec2;
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
		 * All of the gems in the game.
		 */
		protected var gems: Array;

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

		public function Level() {
		}

		public override function setup(): void {
			super.setup();
			floors = [];
			gems = [];
			crates = [];
			objects = [];
			walls = [];
			monsters = [];
			setupCamera();
			setupObjects();
			camera.setTarget(player);
			gravity = new GravityAffector();
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
			} else if(obj is Gem) {
				gems.push(obj);
			} else if(obj is Crate) {
				crates.push(obj);
			} else if(obj is Player) {
				player = Player(obj);
			} else if(obj is Monster) {
				monsters.push(obj);
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
			updateArray(e, objects);
			updateArray(e, floors);
			updateArray(e, walls);
			updateArray(e, crates);
			updateArray(e, gems);
			updateArray(e, monsters);
			player.update(e);
			gravity.affectObject(e, player);
			checkLevelCollisions(e);
		}

		/**
		 * Updates all of the objects in the given array.
		 * @param e:UpdateEvent The current frame update event.
		 * @param arr:Array The array of objects that should be updated.
		 */
		private function updateArray(e: UpdateEvent, arr: Array): void {
			for each(var obj: BoundedObject in arr) {
				obj.update(e);
			}
		}

		/**
		 * Checks for collisions in the level.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function checkLevelCollisions(e: UpdateEvent): void {
			checkCharacterCollisions(e, player);
			checkCollision(e, player, monsters);
			for each(var monster in monsters) {
				checkCharacterCollisions(e, monster);
			}
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
			var gem = checkCollision(e, character, gems);
			var obj = checkCollision(e, character, objects);
			if(!crate && !floor && !obj) {
				character.isGrounded = false;
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
			} else {
				applyNormalCollision(e, dir, first, second);
			}
		}

		/**
		 * Applies the affects of a collision between a character and some other object.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the player needs to move in to fix the overlap.
		 * @param character:Character The player that is colliding with something.
		 * @param second:BoundedObject The object that the player is colliding with.
		 */
		protected function applyCharacterCollision(e: UpdateEvent, dir: Point, character: Character, second: BoundedObject): void {
				if(character is Player && second is Gem) {
					applyPlayerGemCollision(e, dir, Player(character), Gem(second));
				} else if(character is Player && second is Monster) {
					applyPlayerMonsterCollision(e, dir, Player(character), Monster(second));
				} else if(second is Crate) {
					applyCharacterCrateCollision(e, dir, character, Crate(second));
					// Only apply the collision if the player is moving down or the fix is up.
				} else if(character.velocity.y >= 0 || dir.y > 0 || Math.abs(dir.x) > 0) {
					applyNormalCollision(e, dir, character, second);
				}
				if(dir.y < 0) {
					character.isGrounded = true;
				}
		}

		/**
		 * Applies the affects of a collision between a player and a gem.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the player needs to move in to fix the overlap.
		 * @param player:Player The player that is colliding with the gem.
		 * @param gem:Gem The gem that the player is colliding with.
		 */
		protected function applyPlayerGemCollision(e: UpdateEvent, dir: Point, player: Player, gem: Gem): void {
			// TODO: pickup gem
			trace("collect");
			collectGem(e, gem);
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
			player.hurt(monster.damage);
		}

		/**
		 * Applies the affects of a collision between two objects.
		 * @param e:UpdateEvent The current frame update event.
		 * @param dir:Point The direction that the first object needs to move in to fix the overlap.
		 * @param first:MovingObject The object that is colliding with the second.
		 * @param second:MovingObject The object that is being collided with.
		 */
		protected function applyNormalCollision(e: UpdateEvent, dir: Point, first: MovingObject, second: BoundedObject): void {
			first.x += dir.x;
			first.y += dir.y;
			if(dir.x != 0) {
				first.velocity.x = 0;
			}
			if(dir.y != 0) {
				first.velocity.y = 0;
			}
		}

		/**
		 * Collects the given gem and adds it to the player's score.
		 * @param e:UpdateEvent The current frame update event.
		 * @param gem:Gem The gem that should be collected.
		 */
		protected function collectGem(e: UpdateEvent, gem: Gem): void {
			e.playerData.score += gem.worth;
			var i: int = gems.indexOf(gem);
			if(i >= 0) {
				gems.splice(i, 1);
			}
			removeObjectFromDisplay(gem);
		}

	}

}
