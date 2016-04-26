package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;
	import flash.ui.Keyboard;

	/**
	 * Defines a class that represents a character.
	 */
	public class Character extends RectangularObject {

		/**
		 * Whether the character is on the ground or not.
		 */
		public var isGrounded: Boolean = true;

    /**
     * The force, in pixels, that the character jumps at.
     */
    public var jumpForce: Number = 400;

    /**
     * The acceleration, in pixels per second, that the character moves at.
     */
    public var acceleration: Number = 500;

    /**
     * The amount of friction that is applied when the character is not actively moving.
     * Expressed as the factor of slowdown per frame.
     * @default 1.25
     */
    public var staticFriction: Number = 1.25;

    /**
     * The amount of friction that is applied when the character is actively moving/accelerating.
     * Expressed as the factor of slowdown per frame.
     * @default 1.05
     */
    public var dynamicFriction: Number;

		public function Character() {
			// constructor code
		}

		public override function setup(): void {
			super.setup();
			velocity = new Point(0, 0);
		}

    protected override function findNewVelocity(e: UpdateEvent): Point {

    }

    /**
     * Finds the acceleration that should be applied to the character for the frame.
     * @param e:UpdateEvent The current frame update event.
     * @return Point The Point that represents the acceleration that should be applied 
     */
    protected function findAcceleration(e: UpdateEvent): Point {
        return new Point(0, 0);
    }

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - 37.6 / 2);
		}

    public function jump(): void {
      if(isGrounded) {
				velocity.y -= jumpForce;
			}
    }

		public override function update(e: UpdateEvent): void {
			super.update(e);
		}
	}

}
