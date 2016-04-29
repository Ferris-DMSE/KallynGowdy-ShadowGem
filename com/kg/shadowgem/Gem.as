package com.kg.shadowgem {

	import flash.display.MovieClip;
  import flash.geom.Point;
	import com.kg.obj.BoundedObject;
  import com.kg.obj.RectangularObject;

  /**
   * Defines a class that represents a user-collectable gem.
   */
	public class Gem extends Pickup {

		/**
		 * The number of points that this gem is worth.
		 * @default 100
		 */
		public var worth: int = 100;

		public function Gem() {
		}
	}

}
