package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.state.UpdateEvent;

  /**
	 * Defines a class that represents a monster. Mostly used to identify monsters.
	 */
	public class Monster extends Character {

    /**
     * The amount of damage that this monster applies when it touches the player.
     * @default 1
     */
    public var damage: int = 1;

		public function Monster() {
		}

	}

}
