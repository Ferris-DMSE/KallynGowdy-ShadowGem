package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.state.UpdateEvent;

  /**
	 * Defines a class that represents a mouse monster.
	 */
	public class MouseMonster extends Monster {

		public function MouseMonster() {
		}

		protected override function shouldMoveLeft(e: UpdateEvent): Boolean {
			return true;
		}
	}

}
