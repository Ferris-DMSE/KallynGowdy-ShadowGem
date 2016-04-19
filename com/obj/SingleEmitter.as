package com.kg.obj {

	import flash.geom.Point;
  import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents an emitter that emits given objects on demand.
	 */
	public class SingleEmitter extends ObjectEmitter {

    /**
     * Creates a new explosion emitter that can emit objects on demand.
     */
		public function SingleEmitter() {
			super();
		}

    protected override function findSpawnRate(): Number {
      return Number.MAX_VALUE;
    }

    /**
     * Emits the given object from this object at the given position.
     * @param obj:MovingObject The object that should be added to this emitter.
     * @param pos:Point The position that the object should be emitted at.
     */
    public function emitGivenObject(obj: MovingObject, pos: Point = null): void {
      if(pos != null) {
        obj.x = pos.x;
        obj.y = pos.y;
      }
      addObject(obj);
    }
	}

}
