package com.kg.obj {

	import flash.geom.Point;
  import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents an emitter that emits explosions on demand.
	 */
	public class ExplosionEmitter extends ObjectEmitter {

    /**
     * The factory that should be used to emit new explosions from this emitter.
     */
    private var factory: Function;

    /**
     * Creates a new explosion emitter that can emit objects on demand.
     * @param factory:Function A function that, when called, returns a new Explosion object that should be emitted.
     */
		public function ExplosionEmitter(factory: Function) {
			super();
      this.factory = factory;
		}

    protected override function findSpawnRate(): Number {
      return Number.MAX_VALUE;
    }

    /**
     * Emits a new explosion from this object at the given position.
     * @param pos:Point The position that the object should be emitted at.
     */
    public function emitExplosion(pos: Point): void {
      emitObjectAt(pos);
    }

    protected override function createObject(): BoundedObject {
      return factory();
    }

	}

}
