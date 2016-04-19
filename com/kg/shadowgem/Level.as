package com.kg.shadowgem {
	import com.kg.obj.MovingObject;
	import Box2D.Dynamics.b2World;
	import flash.display.DisplayObject;
	import com.kg.obj.BoundedObject;
	import com.kg.obj.ObjectEmitter;
	import Box2D.Common.Math.b2Vec2;
	import com.kg.state.UpdateEvent;
	
	/**
	 * Defines a class that represents a level in the game.
	 * Each level controls its own physics, and at start, loads each of its children and sets them up.
	 */
	public class Level extends ObjectEmitter {

		/**
		 * Gets the default gravity for levels.
		 */
		public static const DEFAULT_GRAVITY: b2Vec2 = new b2Vec2(0, 10);
		
		/**
		 * The world that all of the physics exists in for this level.
		 */
		public var world: b2World;
		
		public function Level() {
		}

		public override function setup(): void {
			super.setup();
			setupObjects();
			setupWorld();
			setupPhysicsObjects();
		}
		
		protected override function findSpawnRate(): Number {
			return Number.MAX_VALUE; // never spawn new things by default.
		}

		/**
		 * Discovers and returns all of the bounded objects in this level.
		 * @return Array The array of BoundedObject entities that exist in this level.
		 */
		private function findObjects(): Array {
			var objects: Array = [];
			for(var i = 0; i < numChildren; i++) {
				var c:BoundedObject = getChildAt(i) as BoundedObject;
				if(c != null) {
					objects.push(c);
				}
			}
			return objects;
		}

		/**
		 * Sets up the objects in this level and adds them to this level's object list.
		 */
		protected function setupObjects(): void {
			var objs: Array = findObjects();
			for each(var obj: BoundedObject in objs) {
				obj.setup();
				objects.push(obj);
			}
		}
		
		/**
		 * Sets up the physics world in this level.
		 */
		protected function setupWorld(): void {
			world = new b2World(DEFAULT_GRAVITY, true);
		}
		
		/**
		 * Adds the physics objects to the physics world.
		 */
		protected function setupPhysicsObjects(): void {
			for each(var obj: BoundedObject in objects) {
				var p: PhysicsObject = obj as PhysicsObject;
				if(p != null) {
					setupPhysicsObject(p);
				}
			}
		}
		
		/**
		 * Sets up the given physics object in the world.
		 * @param obj:PhysicsObject The object that should be setup.
		 */
		protected function setupPhysicsObject(obj: PhysicsObject): void {
			obj.setupPhysics(world);
		}
		
		public override function update(e: UpdateEvent): void {
			world.Step(e.deltaTime, 10, 10);
			super.update(e);
		}
		
	}
	
}
