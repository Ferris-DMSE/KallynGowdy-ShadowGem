package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.obj.MovingObject;
  import com.kg.obj.RectangularObject;
  import flash.geom.Point;
  import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a single particle of dirt.
	 */
	public class DirtParticle extends RectangularObject {

    /**
     * The direction that represents whether the particle should travel in the positive or negative x direction.
     */
    private var direction: int;

    /**
     * The amount of time that this particle has left to live.
     */
    private var lifetime: Number = 0.5;

		public function DirtParticle(dir: int) {
      direction = dir;
		}

    public override function setup(): void {
      super.setup();
      velocity = new Point(direction * Math.random() * 30, -Math.random() * 40 - 50);
    }

    protected override function findColliderPosition(): Point {
      return new Point(x - 1, y - 1);
    }

    public override function update(e: UpdateEvent): void {
      super.update(e);
      lifetime -= e.deltaTime;
      if(lifetime < 0) {
        isDead = true;
      }
    }
	}

}
