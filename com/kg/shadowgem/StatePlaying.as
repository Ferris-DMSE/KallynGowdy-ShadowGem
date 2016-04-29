package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;
	import com.kg.state.GameManager;
	import flash.display.DisplayObject;
	import com.kg.obj.PlayerData;

	/**
	 * Defines the playing state for the game.
	 */
	public class StatePlaying extends State {

		/**
		 * The current level that the player is on.
		 */
		private var level: Level;

		/**
		 * The player data for the game.
		 */
		private var playerData: PlayerData;

		public function StatePlaying() {
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
			level = new Level1();
			addChild(level);
			level.setup();
			playerData = new PlayerData(null);
		}

		protected override function updateCore(e: UpdateEvent): void {
			e.playerData = playerData;
			level.update(e);
		}
	}

}
