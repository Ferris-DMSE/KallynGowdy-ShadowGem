package com.kg.shadowgem {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
  import com.kg.obj.RectangularObject;

	/**
	 * Defines a class that can affect a monster's behavior upon collision.
	 */
	public class MonsterAffector extends RectangularObject {

    /**
     * The array of monsters that were affected during the current frame.
     */
    private var affectedMonsters: Array;

    /**
     * The array of monsters that were affected during the previous frame.
     */
    private var previousMonsters: Array;

		public function MonsterAffector() {
		}

    protected override function findColliderPosition(): Point {
      return new Point(x - width / 2, y - height / 2);
    }

    public override function setup(): void {
      super.setup();
      velocity = new Point(0, 0);
      alpha = 0;
      affectedMonsters = [];
      previousMonsters = [];
    }

    /**
     * Applies the needed affects on the given monster.
     * @param e:UpdateEvent    The current frame update event.
     * @param monster:Monster  The monster that should be affected.
     */
    public function affectMonster(e: UpdateEvent, monster: Monster): void {
      if(previousMonsters.indexOf(monster) < 0) {
        affectMonsterCore(e, monster);
      }
      affectedMonsters.push(monster);
    }

    /**
     * When implemented in a derived class, applies the needed affects on the given monster.
     * @param e:UpdateEvent    The current frame update event.
     * @param monster:Monster  The monster that should be affected.
     */
    protected function affectMonsterCore(e: UpdateEvent, monster: Monster): void {
    }

    public override function update(e: UpdateEvent): void {
      super.update(e);
      previousMonsters = affectedMonsters;
      affectedMonsters = [];
    }
	}

}
