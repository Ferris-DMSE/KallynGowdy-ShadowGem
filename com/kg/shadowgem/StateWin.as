package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;
	import com.kg.state.GameManager;

  /**
	 * Defines a class that represents the win state.
	 */
	public class StateWin extends State {

		/**
		 * The data that the game ended with.
		 */
		private var playerData: ShadowGemPlayerData;

		/**
		 * Creates a new win state.
		 * @param playerData:ShadowGemPlayerData The data that the game ended with.
		 */
		public function StateWin(playerData: ShadowGemPlayerData) {
			this.playerData = playerData;
		}

		public override function setup(game: GameManager): void {
			super.setup(game);
			extraText.text = "Robo was able to collect $ " + playerData.score + " with your help!\nPlay Again?"
		}

		protected override function updateCore(e: UpdateEvent): void {
			if(playButton.clicked) {
				e.game.switchState(new StatePlaying());
			}
			if(quitButton.clicked) {
				e.game.switchState(new StateTitle());
			}
			playButton.update(e);
			quitButton.update(e);
		}

		public override function dispose(): void {
			super.dispose();
			playButton.dispose();
			quitButton.dispose();
		}
	}

}
