package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.state.UpdateEvent;
	import flash.geom.Point;
	import com.kg.obj.MovingObject;

	/**
	 * Defines a class that represents a monster that, when touched, instantly kills the player.
	 */
	public class InstantDeathMonster extends Monster {

		public function InstantDeathMonster() {
			super();
			damage = 1000000;
		}
	}

}
