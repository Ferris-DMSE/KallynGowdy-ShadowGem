package com.kg.shadowgem {
	
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;	
	
	/**
	 * Defines a class that represents a floor.
	 */
	public class MetalFloor extends PhysicsObject {
		
		public function MetalFloor() {
			var def: b2BodyDef = getDefaultBodyDef();
			def.type = b2Body.b2_staticBody;
			super(def);
		}
		
		public override function setupPhysics(world: b2World): void {
			super.setupPhysics(world);
			var shape: b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width / 2 * PIXELS_TO_METERS, height / 2 * PIXELS_TO_METERS);
			var fixtureDef: b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = 1.0;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.2;
			physicsBody.CreateFixture(fixtureDef);
		}
	}
	
}
