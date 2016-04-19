package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;
	import Box2D.Dynamics.b2World;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2FixtureDef;
	import com.kg.state.GameManager;
	import flash.display.DisplayObject;
	import com.kg.obj.ObjectEmitter;

	/**
	 * Defines the playing state for the game.
	 */
	public class StatePlaying extends State {
		
		/**
		 * The world that simulates the physics for the game.
		 */
		private var world: b2World;		
		
		private var level: Level;

		public function StatePlaying() {
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
			level = new Level1();
			addChild(level);
			level.setup();
		}

		protected override function updateCore(e: UpdateEvent): void {
			level.update(e);
		}
	}

}
