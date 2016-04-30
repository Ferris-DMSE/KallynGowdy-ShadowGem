package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.GameManager;

	/**
	 * Defines a class that represents the shadowgem game.
	 */
	public class Game extends GameManager {

		public function Game() {
			switchState(new StateTitle());
		}
	}

}
