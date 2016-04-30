package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.State;
	import com.kg.state.UpdateEvent;

  /**
	 * Defines a class that represents the title state.
	 */
	public class StateTitle extends State {

		public function StateTitle() {
		}

		protected override function updateCore(e: UpdateEvent): void {
			if(playButton.clicked) {
				e.game.switchState(new StatePlaying());
			}
			playButton.update(e);
		}

		public override function dispose(): void {
			super.dispose();
			playButton.dispose();
		}
	}

}
