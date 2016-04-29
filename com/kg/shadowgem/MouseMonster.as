package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.state.UpdateEvent;
	import flash.geom.Point;

  /**
	 * Defines a class that represents a mouse monster.
	 */
	public class MouseMonster extends Monster {

		public function MouseMonster() {
		}

	  public override function setup(): void {
			super.setup();
			velocity = new Point(150, 0);
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			if(velocity.x < 0) {
				// moving left, reflect player scale
				scaleX = 1;
			} else {
				// moving right, normal
				scaleX = -1;
			}
		}
	}

}
