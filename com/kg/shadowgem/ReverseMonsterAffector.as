package com.kg.shadowgem {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a monster affector that can reverse the direction of a monster's movement.
	 */
	public class ReverseMonsterAffector extends MonsterAffector {

		public function ReverseMonsterAffector() {
		}

    protected override function affectMonsterCore(e: UpdateEvent, monster: Monster): void {
      monster.velocity = new Point(-monster.velocity.x, -monster.velocity.y);
    }
	}

}
