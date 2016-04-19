﻿package com.kg.shadowgem {
	
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	
	/**
	 * Defines a crate that exists in the game as an obstacle.
	 */
	public class Crate extends PhysicsObject {
		
		public function Crate() {
			var def: b2BodyDef = getDefaultBodyDef();
			def.type = b2Body.b2_dynamicBody;
			super(def);
		}
		
		public override function setupPhysics(world: b2World): void {
			super.setupPhysics(world);
			var shape: b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(25 * PIXELS_TO_METERS, 25 * PIXELS_TO_METERS);
			var fixtureDef: b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = 1.0;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.2;
			physicsBody.CreateFixture(fixtureDef);
		}
	}
	
}
