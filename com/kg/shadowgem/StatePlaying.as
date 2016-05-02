package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;
	import com.kg.state.GameManager;
	import flash.display.DisplayObject;
	import com.kg.obj.PlayerData;
	import flash.ui.Keyboard;

	/**
	 * Defines the playing state for the game.
	 */
	public class StatePlaying extends State {

		/**
		 * The array of level factories.
		 */
		private static var levels: Array = [
			createLevel1,
			createLevel2
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
				exitCurrentLevel(e);
			}
			if(e.keys.onUp(Keyboard.ESCAPE)) {
				e.game.surroundState(new StatePaused(this));
			}
			updateHud(e);
		}

		/**
		 * Exits the current level and returns to the level selection level.
		 * @param e:UpdateEvent The current frame update event.
		 */
		private function exitCurrentLevel(e: UpdateEvent): void {
			if(level is MainLevel) {
				loadLevel(levels[currentLevelIndex]());
			} else {
				currentLevelIndex++;
				if(currentLevelIndex >= levels.length) {
					e.game.switchState(new StateWin(playerData));
				} else {
					playerData.livesLeft = 3;
					loadLevel(new MainLevel(currentLevelIndex));
				}
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
			addChildAt(this.level, 0);
			this.level.setup();
		}

		/**
		 * Creates the first level, Level 1.
		 */
		private static function createLevel1(): Level {
			return new Level1();
		}

		/**
		 * Creates the second level, Level 2.
		 */
		private static function createLevel2(): Level {
			return new Level2();
		}

		/**
		 * Updates the game's UI HUD.
		 * @param e:UpdateEvent The current frame update event.
		 */
		private function updateHud(e: UpdateEvent): void {
			heart1.alpha = playerData.livesLeft >= 1 ? 1 : 0;
			heart2.alpha = playerData.livesLeft >= 2 ? 1 : 0;
			heart3.alpha = playerData.livesLeft >= 3 ? 1 : 0;
			ammoText.text = playerData.ammo.toString();
			scoreText.text = "$ " + playerData.score.toString();
		}
	}

}
