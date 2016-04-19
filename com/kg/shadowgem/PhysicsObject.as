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
		public function PhysicsObject(bodyDef: b2BodyDef) {
			this.bodyDef = bodyDef;
		}

		/**
		 * Sets up the physics needed for this object.
		 * In the lifetime of the object, setupPhysics is called after setup().
		 * @param world:b2World The world that this object should be setup in.
		 */
		public function setupPhysics(world: b2World): void {
			this.world = world;
			physicsBody = world.CreateBody(bodyDef);
		}
		
		/**
		 * Retrieves a default body definition that can be used for the object.
		 * Essentially returns an identity body def, but with position and angle updated.
		 * @return b2BodyDef The Default Body Definition.
		 */
		protected function getDefaultBodyDef(): b2BodyDef {
			var bodyDef: b2BodyDef = new b2BodyDef();
			bodyDef.position = new b2Vec2(x * PIXELS_TO_METERS, y * PIXELS_TO_METERS);
			bodyDef.angle = rotation * Math.PI / 180;
			return bodyDef;
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
			world.DestroyBody(physicsBody);
		}
	}
	
}
