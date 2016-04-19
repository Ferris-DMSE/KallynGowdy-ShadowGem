package com.kg.obj {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
  import com.kg.state.IUpdatable;

	/**
	 * Defines a class that can affect a group of objects.
	 */
	public class ObjectAffector implements IUpdatable {

    public function ObjectAffector() {

    }

    /**
     * Applies the affects of this affector to each of the given objects.
     * @param e:UpdateEvent The current frame update event.
     * @param objects:Array The array of MovingObject entities that should be affected.
     */
    public function affectObjects(e: UpdateEvent, objects: Array): void {
      for each(var obj: MovingObject in objects) {
				if(obj != null) {
					var emitter: ObjectEmitter = obj as ObjectEmitter;
					if(emitter != null) {
						affectObjects(e, emitter.objects);
					} else {
						affectObject(e, obj);
					}
				}
      }
    }

    /**
     * Applies the affects of this affector to the given object.
     * @param e:UpdateEvent The current frame update event.
     * @param obj:MovingObject The object that should be affected.
     */
    public function affectObject(e: UpdateEvent, obj: MovingObject): void {
      trace("No Effects Were Applied");
    }

		/**
		 * Updates whatever global state that this affector has.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public function update(e: UpdateEvent): void {
		}

	}

}
