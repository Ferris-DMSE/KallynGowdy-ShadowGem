package com.kg.obj {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import com.kg.state.IUpdatable;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines an abstract class that represents a generic object emitter.
	 */
	public class ObjectEmitter extends MovingObject implements IUpdatable {

		/**
		 * Creates a new Object Emitter.
		 */
		public function ObjectEmitter() {
		}

		/**
		 * The array of objects that have been emitted.
		 */
		public var objects: Array = [];

		/**
		 * The last time that a object was spawned at.
		 */
		private var lastSpawnTime: Number = 0;

		/**
		 * The total number of objects that have been emitted from this emitter.
		 */
		protected var objectsEmitted: int = 0;

		/**
		 * Runs the update cycle for the object emitter.
		 */
		public override function update(e: UpdateEvent): void {
			super.update(e);
			updateObjects(e);
			emitObjects(e);
		}

		/**
		 * Emits a new object if the time is right. Otherwise, nothing occurs.
		 */
		protected function emitObjects(e: UpdateEvent): void {
			var nextTime = lastSpawnTime + findSpawnRate();
			if(nextTime < e.currentTime) {
				lastSpawnTime = e.currentTime;
				emitObject();
			}
		}

		/**
		 * Determines the spawn rate for the given level number.
		 * @param levelNum:int The number of the level that the spawn rate should be found for.
		 * @return Number Returns the number of seconds between spawns.
		 */
		protected function findSpawnRate(): Number {
			return int.MAX_VALUE;
		}

		/**
		 * Emits a new object at a random position dictated by the minimum and maximum x and Y values of this object.
		 */
		protected function emitObject() : void {
			var obj = createObject();
			var p:Point = findSpawnLocation(obj);
			obj.x = p.x;
			obj.y = p.y;
			addObject(obj);
		}

		/**
		 * Emits a new object at the given position.
		 * @param pos:Point The position that the object should be emitted at.
		 */
		protected function emitObjectAt(pos: Point): void {
			var obj = createObject();
			obj.x = pos.x;
			obj.y = pos.y;
			addObject(obj);
		}

		/**
		 * Finds the location that the given object should be placed at to start it's life.
		 * @param obj:BoundedObject The object that the spawn position should be found for.
		 */
		protected function findSpawnLocation(obj: BoundedObject): Point {
			return new Point(0, 0);
		}

    /**
		 * Adds the given object to this emitter's hierarchy and update loop.
		 * @param obj:BoundedObject The object that should be added to this emitter.
		 */
		protected function addObject(obj: BoundedObject): void {
			objectsEmitted++;
			addChild(obj);
			obj.setup();
			objects.push(obj);
		}

		/**
		 * Adds the given object to this emitter's hierarchy at the given position.
		 * @param obj:BoundedObject The object that should be added to this emitter.
		 * @param position:int The position in the hierarch that this object should be added at.
		 */
		protected function addObjectAt(obj: BoundedObject, position: int): void {
			objectsEmitted++;
			addChildAt(obj, position);
			obj.setup();
			objects.push(obj);
		}

		/**
		 * Creates a new object that will be emitted.
		 */
		protected function createObject(): BoundedObject {
			throw new Error("Cannot create an object because createObject() was not overridden in the derived class.");
		}

		/**
		 * Updates all of the objects controlled by this emitter.
		 * @param e:UpdateEvent The current update event.
		 */
		protected function updateObjects(e: UpdateEvent): void {
			for(var i = 0; i < objects.length; i++) {
				var obj: BoundedObject = objects[i];
				updateObject(obj, e);
			}
		}

		/**
		 * Removes the given object from this emitter.
		 * @param obj:BoundedObject The object that should be removed.
		 */
		public function removeObject(obj: BoundedObject): void {
			for(var i = 0; i < objects.length; i++) {
				var o: BoundedObject = objects[i];
				if(o == obj) {
					obj.dispose();
					objects.splice(i, 1);
					removeObjectFromDisplay(obj);
					break;
				}
			}
		}

		/**
		 * Removes the given object from the display tree.
		 * @param obj:BoundedObject The object that should be removed from the display tree.
		 */
		protected function removeObjectFromDisplay(obj: BoundedObject): void {
			removeChild(obj);
		}

		/**
		 * Runs the proper update logic for the given object.
		 * @param obj:BoundedObject The object that should be updated.
		 * @param e:UpdateEvent The current update event.
		 */
		private function updateObject(obj: BoundedObject, e: UpdateEvent): void {
			if(!checkObjectDeath(obj)) {
				obj.update(e);
			}
		}

		/**
		 * Checks the given object for death and returns whether it is in fact, dead.
		 * If the object is dead, then it is removed from this emitter.
		 * @param obj:BoundedObject The object to check for death.
		 */
		private function checkObjectDeath(obj: BoundedObject): Boolean {
			if(obj.isDead) {
				removeObject(obj);
				return true;
			}
			return false;
		}

		/**
		 * Checks for collisions between the player and the objects that this emitter have emitted and
		 * returns the object that the player collided with.
		 * @param player:Player The player to check collisions against.
		 */
		public function checkCollisions(player: BoundedObject) : BoundedObject {
			return BoundedObject(player.findCollision(objects));
		}

		/**
		 * Gets the array of objects that are within the given distance of the given point.
		 * @param point:Point The point that retrieved objects should be near.
		 * @param dist:Number The distance.
		 */
		protected function objectsWithinDistanceOfPoint(point: Point, dist: Number): Array {
			return objects.filter(function(obj) {
					return obj.isWithinDistance(point, dist);
				});
		}

	}

}
