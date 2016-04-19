package com.kg.shadowgem {
	import com.kg.obj.BoundedObject;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.geom.Point;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	import com.kg.state.UpdateEvent;
	
	/**
	 * Defines a class that represents an object that uses Box2D physics to control its movement.
	 */
	public class PhysicsObject extends BoundedObject {

		/**
		 * The conversion rate from pixels to meters.
		 */
		public static const PIXELS_TO_METERS: Number = 1/50;
		
		/**
		 * The convertion rate from meters to pixels.
		 */
		public static const METERS_TO_PIXELS: Number = 50;
		
		/**
		 * Gets the body that the physics object should exist at.
		 */
		public var physicsBody: b2Body;
		
		/**
		 * The body definition that should be used to setup the body.
		 */
		private var bodyDef: b2BodyDef;

		/**
		 * The world that the physics body belongs to.
		 */
		private var world: b2World;
		
		/**
		 * Creates a new physics object.
		 * @param world:b2World      The world that the object should exist in.
		 * @param bodyDef:b2BodyDef  The body definition that should be used to create the physics body.
		 */
		public function PhysicsObject(world: b2World, bodyDef: b2BodyDef) {
			this.bodyDef = bodyDef;
			this.world = world;
		}

		public override function setup(): void {
			super.setup();
			physicsBody = world.CreateBody(bodyDef);
		}
		
		public override function update(e: UpdateEvent): void {
			super.update(e);
			updatePosition();
			updateRotation();
		}
		
		/**
		 * Updates the position of the display object.
		 */
		private function updatePosition(): void {
			var pos: b2Vec2 = physicsBody.GetPosition();
			x = pos.x * METERS_TO_PIXELS;
			y = pos.y * METERS_TO_PIXELS;
		}
		
		/**
		 * Updates the rotation of the display object.
		 */
		private function updateRotation(): void {
			var angle: Number = physicsBody.GetAngle();
			rotation = angle * 180 / Math.PI;			
		}
		
		public override function dispose(): void {
			super.dispose();
			this.world.DestroyBody(physicsBody);
		}
	}
	
}
