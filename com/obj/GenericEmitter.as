package com.kg.obj {

	import flash.geom.Point;
  import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents an emitter that emits a random choice from a list of objects at a specified interval.
	 */
	public class GenericEmitter extends ObjectEmitter {

    /**
     * The factories that should be used to emit objects.
     */
    private var factories: Array;

    /**
     * The amount of time (in seconds) between spawns from this emitter.
     */
    public var spawnRate: Number = 1;

    /**
     * The next factory that will be called.
     */
    private var nextFactory: Function;

    /**
     * The X-Axis range that new objects are spawned between.
     * @default new Point(0, 0)
     */
    public var xRange: Point = new Point(0, 0);

    /**
     * The Y-Axis range that new objects are spawned between.
     * @default new Point(0, 100)
     */
    public var yRange: Point = new Point(0, 100);

    /**
     * Creates a new emitter that can emit objects from the given list of factories.
     * @param factories:Array An array of functions that create and return an object when called.
     */
		public function GenericEmitter(factories: Array) {
			super();
      this.factories = factories;
      this.nextFactory = findNextFactory();
		}

    protected override function findSpawnRate(): Number {
      return spawnRate;
    }

    protected override function findSpawnLocation(obj: BoundedObject): Point {
      return new Point(Utils.randomBetween(xRange.x, xRange.y), Utils.randomBetween(yRange.x, yRange.y));
    }

    protected override function createObject(): BoundedObject {
      var obj: BoundedObject = nextFactory();
      nextFactory = findNextFactory();
      return obj;
    }

    private function findNextFactory(): Function {
      return factories[int(Utils.randomBetween(0, factories.length))];
    }

	}

}
