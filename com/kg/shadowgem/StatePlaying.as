package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;
	import com.kg.state.GameManager;
	import flash.display.DisplayObject;

	/**
	 * Defines the playing state for the game.
	 */
	public class StatePlaying extends State {

		/**
		 * The current level that the player is on.
		 */
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
