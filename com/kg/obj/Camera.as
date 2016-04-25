package com.kg.obj {

  import flash.geom.Point;
  import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents an object that represents a camera system.
	 */
	public class Camera extends MovingObject {

    /**
     * The number of pixels that the camera should be offset from the actual position by.
     */
    private var offset: Point;

    /**
     * The minimum coordinates that the camera can be at.
     */
    private var boundsMin: Point;

    /**
     * The maximum coordinates that the camera can be at.
     */
    private var boundsMax: Point;

    /**
     * The object that this camera should follow.
     */
    private var target: BoundedObject;

    /**
     * The inner movie clip that is used to house the objects that are displayed in this camera.
     */
    private var canvas: MovieClip;

    /**
     * The position that this camera should "act" from. That is, where this camera should believe it exists at.
     */
    private var actualPos: Point;

    /**
     * Creates a new camera that lives at the given offset.
     * @param offset:Point The position that this camera should start at.
     */
		public function Camera(offset: Point) {
      this.offset = offset.copy();
      this.canvas = new MovieClip();
      actualPos = new Point();
		}

    protected override function findNewVelocity(): Point {
      if(target != null) {
        var targetPos = new Point(-target.x, -target.y);
        // find the direction that the camera should move in and normalize it.
        var targetDir = new Point(targetPos.x - actualPos.x, targetPos.y - actualPos.y);
        var magnitude: Number = Math.sqrt(targetDir.x * targetDir.x + targetDir.y * targetDir.y);
        targetDir = new Point(targetDir.x / magnitude, targetDir.y / magnitude);

        return new Point(targetDir.x * 20, targetDir.y * 20);
      }
      return new Point(0, 0);
    }

    protected override function updatePosition(e: UpdateEvent): void {
      velocity = findNewVelocity(e);
      actualPos = new Point(actualPos.x + velocity.x * e.deltaTime, actualPos.y + velocity.y * e.deltaTime);
      canvas.x = actualPos.x;
      canvas.y = actualPos.y;

      // implement shake here:
    }

    /**
     * Adds the given object to this camera's display tree.
     * @param obj:DisplayObject The object that should react to the camera system.
     */
    public function addContent(obj: DisplayObject): void {
      canvas.addChild(obj);
    }

	}

}
