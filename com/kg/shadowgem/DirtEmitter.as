package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.obj.ObjectEmitter;
  import com.kg.obj.BoundedObject;
  import com.kg.obj.MovingObject;
  import flash.geom.Point;

	/**
	 * Defines a class that represents an emitter that emits dirt particles near it's target.
	 */
	public class DirtEmitter extends ObjectEmitter {

    /**
     * The target for this emitter.
     */
    private var target: Character;

    /**
     * The offset that particles are placed at.
     */
    private var offset: Point;

    /**
     * Creates a new dirt emitter.
     * @param target:Character The character that this emitter should emit dirt particles near.
     * @param offset:Point The offset that dirt particles should be placed at relative to the target.
     */
		public function DirtEmitter(target: Character, offset: Point) {
      this.target = target;
      this.offset = offset;
		}

    protected override function findSpawnLocation(obj: BoundedObject): Point {
      return new Point(target.x + offset.x, target.y + offset.y);
    }

    protected override function createObject(): BoundedObject {
      return new DirtParticle(target.velocity.x/Math.abs(target.velocity.x));
    }

    protected override function findSpawnRate(): Number {
      if(target.isGrounded) {
        return 2/(Math.abs(target.velocity.x));
      } else {
        return Number.MAX_VALUE;
      }
    }
	}

}
