package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that can affect object velocities to obey gravity.
	 */
	public class ShakeAffector extends ObjectAffector {

    /**
     * The strength of the shake. This determines how "deep" the oscilation is.
     */
    public var strength: Number = 600;

    /**
     * The frequency of the shake. This determines how fast the oscilation is.
     */
    public var frequency: Number = 10000;

    /**
     * The amount of shake that is left in the affector.
     */
    public var duration: Number = 0;

		public function ShakeAffector() {
		}

		public override function affectObject(e: UpdateEvent, obj: BoundedObject): void {
			var moving: MovingObject = obj as MovingObject;
			if(moving != null) {
				if(duration > 0) {
					obj.y = Math.cos(obj.x * frequency) * e.deltaTime * strength;
        	obj.x = Math.cos(obj.y * frequency) * e.deltaTime * strength;
				} else {
        	obj.y = 0;
        	obj.x = 0;
      	}
			}
		}

    public override function update(e: UpdateEvent): void {
      super.update(e);
      duration -= e.deltaTime;
      if(duration < 0) {
        duration = 0;
      }
    }
	}

}
