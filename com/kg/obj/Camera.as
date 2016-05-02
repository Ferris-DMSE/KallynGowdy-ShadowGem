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
     * The minimum X position that this camera can have.
     */
    public var minX: Number = 0;

    /**
     * The maximum Y position that this camera can have.
     */
    public var maxY: Number = 540;

    /**
     * The amount of shake that is left in the camera.
     */
    private var shakeAmount: Number = 0;

    /**
     * The strength of the camera shake over time.
     */
    public var shakeStrength: Number = 25;

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
        if(-(targetPos.y - offset.y * 2) > maxY) {
          targetPos.y = -(maxY - offset.y * 2);
        }
        if(-targetPos.x < minX) {
          targetPos.x = -minX;
        }
        // find the direction that the camera should move in and normalize it.
        var targetDir = new Point(targetPos.x - actualPos.x, targetPos.y - actualPos.y);
        var magnitude: Number = Math.sqrt(targetDir.x * targetDir.x + targetDir.y * targetDir.y);

        if(magnitude > padding) {
          targetDir = new Point(targetDir.x / magnitude, targetDir.y / magnitude);

          return new Point(targetDir.x * acceleration, targetDir.y * acceleration);
        } else {
          return new Point(0, 0);
        }
      }
      return new Point(0, 0);
    }

    protected override function updatePosition(e: UpdateEvent): void {
      velocity = findNewVelocity(e);
      actualPos = new Point(actualPos.x + velocity.x * e.deltaTime, actualPos.y + velocity.y * e.deltaTime);
      canvas.x = actualPos.x;
      canvas.y = actualPos.y;
      rotation = 0;

      // implement shake here:
      if(shakeAmount > 0) {
        var shake: Number = shakeStrength * shakeAmount;
        canvas.x += Math.random() * shake;
        canvas.y += Math.random() * shake;
        /*rotation += Math.random() * shake;*/

        shakeAmount -= e.deltaTime;
      }
    }

    /**
     * Adds the given object to this camera's display tree.
     * @param obj:DisplayObject The object that should react to the camera system.
     */
    public function addContent(obj: DisplayObject): void {
      canvas.addChild(obj);
    }

    /**
     * Adds the given object to this camera's display tree in a position that is unaffected by the camera's movement.
     * @param obj:DisplayObject The object that should be added to the camera.
     */
    public function addStaticContent(obj: DisplayObject): void {
      addChild(obj);
    }

    /**
     * Removes the given object from this camera's display tree.
     * @param obj:DisplayObject The object that should be removed from the camera's display.
     */
    public function removeContent(obj: DisplayObject): void {
      canvas.removeChild(obj);
    }

    /**
     * Removes the given object from this camera's static display tree.
     * @param obj:DisplayObject The object that should be removed from the camera's display.
     */
    public function removeStaticContent(obj: DisplayObject): void {
      removeChild(obj);
    }

    /**
     * Sets the target that this camera should track.
     * @param target:BoundedObject The object that should be followed by the camera.
     */
    public function setTarget(target: BoundedObject): void {
      this.target = target;
    }

    /**
     * Shakes the camera for the specified amount of time.
     * @param duration:Number The amount of time, in seconds that the camera should shake for.
     */
    public function shake(duration: Number): void {
      shakeAmount += duration;
    }

	}

}
