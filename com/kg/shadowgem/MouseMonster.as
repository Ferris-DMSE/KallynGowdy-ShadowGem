package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.state.UpdateEvent;

  /**
	 * Defines a class that represents a mouse monster.
	 */
	public class MouseMonster extends Monster {

		/**
		 * The amount of time in seconds that the mouse should move in a single direction.
		 */
		public var moveTime: Number = 5;

		/**
		 * The amount of time left in seconds that the mouse should move before switching directions.
		 */
		private var moveTimeLeft: Number;

		/**
		 * Whether the mouse is currently moving left. When false, this means the mouse is moving right.
		 */
		private var movingLeft: Boolean;

		public function MouseMonster() {
		}

		public override function setup(): void {
			super.setup();
			moveTimeLeft = moveTime;
		}

		protected override function shouldMoveLeft(e: UpdateEvent): Boolean {
			return movingLeft;
		}

		protected override function shouldMoveRight(e: UpdateEvent): Boolean {
			return !movingLeft;
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
			moveTimeLeft -= e.deltaTime;
			if(moveTimeLeft < 0) {
				movingLeft = !movingLeft;
				moveTimeLeft = moveTime;
			}
		}
	}

}
