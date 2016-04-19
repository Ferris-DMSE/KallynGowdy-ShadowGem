package com.kg.obj {
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import com.kg.state.UpdateEvent;
	import com.kg.state.IUpdatable;

	/**
	 * Defines an abstract class that represents a recorded list of points that follow behind an object.
	 */
	public class Tail extends Sprite implements IUpdatable {

		/**
		 * The velocity that each sampled point should have.
		 */
		public var velocity: Point = new Point(0, 0);

		/**
		 * The Array of points that the tail has recorded.
		 */
		private var points: Array = [];

		/**
		 * The amount of time, in seconds, between recorded points.
		 */
		public var timeBetweenRecordedPoints: Number = .01;

		/**
		 * The maximum number of points that can be recorded.
		 */
		public var maxNumberRecordedPoints: int = 45;

		/**
		 * The next time that a point should be recorded.
		 */
		private var nextRecordTime: Number = -1;

		/**
		 * The object that the tail follows.
		 */
		protected var obj: DisplayObject;

		/**
		 * The last position that the followed object existed at.
		 */
		protected var previousPos:Point;

		/**
		 * How much the tail's points should be offset from the originally recorded points.
		 */
		public var offset: Point = new Point(0, 0);

		/**
		 * Creates a new tail that follows the given object.
		 * @param obj:DisplayObject The object that the tail should follow.
		 */
		public function Tail(obj: DisplayObject) {
			this.obj = obj;
		}

		/**
		 * Updates the tail.
		 */
		public function update(e: UpdateEvent): void {
			processUpdate(e);
			draw(e, points);
		}


		/**
		 * Processes the main update logic for the sampled points in the tail.
		 * @param e:UpdateEvent The update event.
		 */
		private function processUpdate(e: UpdateEvent): void {
			if(previousPos == null) {
				recordPreviousPos();
			}
			recordPoint(e);
			updatePoints(e);
			recordPreviousPos();
		}

		/**
		 * Records the position that the object is at for later use.
		 */
		private function recordPreviousPos(): void {
			previousPos = new Point(obj.x, obj.y);
		}

		/**
		 * Updates the sampled points.
		 * @param e:UpdateEvent The update event.
		 */
		private function updatePoints(e: UpdateEvent): void {
			for(var i:int = 0; i < points.length; i++) {
				var p:Point = points[i];

				p.x += velocity.x;
				p.y += velocity.y;
			}
		}

		/**
		 * Records a new tail point if the time is "right".
		 * @param e:UpdateEvent The update event.
		 */
		private function recordPoint(e: UpdateEvent): void {
			if(nextRecordTime < e.currentTime) {
				points.push(new Point(obj.x + offset.x, obj.y + offset.y));
				nextRecordTime = e.currentTime + timeBetweenRecordedPoints;
			}

			if(points.length > maxNumberRecordedPoints) {
				points.shift();
			}
		}

		/**
		 * Draws the given array of points on the screen.
		 * Needs to be implemented in inherited classes, and should not call super.draw(points).
		 * @param e:UpdateEvent The frame update event.
		 * @param points:Array The array of Point objects that the tail should be drawn over.
		 */
		protected function draw(e: UpdateEvent, points: Array): void {
			throw new Error("draw(points) is not implemented in an inherited Tail class.");
		}
	}

}
