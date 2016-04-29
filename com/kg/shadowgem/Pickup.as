package com.kg.shadowgem {

	import flash.display.MovieClip;
  import flash.geom.Point;
	import com.kg.obj.BoundedObject;
  import com.kg.obj.RectangularObject;

  /**
   * Defines a class that represents a user-collectable object.
   */
	public class Pickup extends RectangularObject {

		public function Pickup() {
		}

    public override function setup(): void {
      super.setup();
      velocity = new Point(0, 0);
      // Gems do not die when offscreen
      xMin = int.MIN_VALUE;
      xMax = int.MAX_VALUE;
      yMin = int.MIN_VALUE;
      yMax = int.MAX_VALUE;
    }

    protected override function findColliderPosition(): Point {
      return new Point(x - width / 2, y - width / 2);
    }
	}

}
