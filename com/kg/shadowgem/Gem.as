package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.BoundedObject;

  /**
   * Defines a class that represents a user-collectable gem.
   */
	public class Gem extends BoundedObject {

		public function Gem() {
		}

    public override function setup(): void {
      super.setup();
      // Gems do not die when offscreen
      xMin = int.MIN_VALUE;
      xMax = int.MAX_VALUE;
      yMin = int.MIN_VALUE;
      yMax = int.MAX_VALUE;
    }
	}

}
