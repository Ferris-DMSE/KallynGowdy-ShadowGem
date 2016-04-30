package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.GameManager;

	public class Game extends GameManager {

		public function Game() {
			switchState(new StateTitle());
		}
	}

}
