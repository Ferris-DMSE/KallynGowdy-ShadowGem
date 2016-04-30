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
		 * The array of level factories.
		 */
		private static var levels: Array = [
			createLevel1
		];

		/**
		 * The level that the player is currently on.
		 */
		private var currentLevelIndex: int;

		/**
		 * The current level that the player is on.
		 */
		private var level: Level;

		/**
		 * The player data for the game.
		 */
		private var playerData: ShadowGemPlayerData;

		public function StatePlaying() {
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
			currentLevelIndex = 0;
			loadLevel(new MainLevel(currentLevelIndex));
			playerData = new ShadowGemPlayerData(null);
		}

		protected override function updateCore(e: UpdateEvent): void {
			e.playerData = playerData;
			level.update(e);
			if(level.isDead) {
				exitCurrentLevel();
			}
		}

		/**
		 * Exits the current level and returns to the level selection level.
		 */
		private function exitCurrentLevel(): void {
			if(level is MainLevel) {
				loadLevel(levels[currentLevelIndex]());
			} else {
				loadLevel(new MainLevel(++currentLevelIndex));
			}
		}

		/**
		 * Loads the current level into the game.
		 * @param level:Level The level that should be loaded.
		 */
		private function loadLevel(level: Level): void {
			if(this.level) {
				this.level.dispose();
				removeChild(this.level);
			}
			this.level = level;
			addChild(this.level);
			this.level.setup();
		}

		/**
		 * Creates the first level, Level 1.
		 */
		private static function createLevel1(): Level {
			return new Level1();
		}
	}

}
