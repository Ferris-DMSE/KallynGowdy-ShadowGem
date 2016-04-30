package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;

  /**
	 * Defines a class that represents the losing state.
	 */
	public class StateLoss extends State {

		public function StateLoss() {
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
