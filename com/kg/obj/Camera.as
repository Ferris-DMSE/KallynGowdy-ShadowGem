package com.kg.obj {

  import flash.geom.Point;
  import flash.display.DisplayObject;
  import com.kg.state.UpdateEvent;
  import flash.display.MovieClip;

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
     * The acceleration that the camera has in pixels per second.
     * @default 200
     */
    public var acceleration: Number = 200;

    /**
     * The number of pixels that the player is allowed to move from the center of the camera offset.
     * @default 10;
     */
    public var padding: Number = 10;

    /**
     * Creates a new camera that lives at the given offset.
     * @param offset:Point The position that this camera should start at.
     */
		public function Camera(offset: Point) {
      this.offset = offset.clone();
      this.canvas = new MovieClip();
      actualPos = new Point(0, 0);
      addChild(canvas);
		}

    protected override function findNewVelocity(e: UpdateEvent): Point {
      if(target != null) {
        var targetPos = new Point(-target.x + offset.x, -target.y + offset.y);
        // find the direction that the camera should move in and normalize it.
        var targetDir = new Point(targetPos.x - actualPos.x, targetPos.y - actualPos.y);
        var magnitude: Number = Math.sqrt(targetDir.x * targetDir.x + targetDir.y * targetDir.y);

        if(magnitude > padding) {
          targetDir = new Point(targetDir.x / magnitude, targetDir.y / magnitude);

          return new Point(targetDir.x * acceleration, targetDir.y * acceleration);
        } else {
          return new Point(targetDir.x / 1.2, targetDir.y / 1.2);
        }
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

    /**
     * Removes the given object from this camera's display tree.
     * @param obj:DisplayObject The object that should be removed from the camera's display.
     */
    public function removeContent(obj: DisplayObject): void {
      canvas.removeChild(obj);
    }

    /**
     * Sets the target that this camera should track.
     * @param target:BoundedObject The object that should be followed by the camera.
     */
    public function setTarget(target: BoundedObject): void {
      this.target = target;
    }

	}

}
