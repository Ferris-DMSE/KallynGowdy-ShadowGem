package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.MovingObject;
	import com.kg.state.UpdateEvent;
	import flash.geom.Point;

	/**
	 * Defines a class that represents the main level that the character plays in.
	 */
	public class MainLevel extends Level {

		/**
		 * The index of the next level to go to.
		 */
		private var nextLevelIndex: int;

		/**
		 * Creates a new main level that exits when the next level should be loaded.
		 * @param nextLevelIndex:int The index of the next level that should be loaded.
		 */
		public function MainLevel(nextLevelIndex: int) {
			super();
			this.nextLevelIndex = nextLevelIndex;
		}

		public override function setup(): void {
			super.setup();
			var playerSpawnTarget = monsterAffectors[nextLevelIndex];
			player.x = playerSpawnTarget.x;
			player.y = playerSpawnTarget.y;
		}

		protected override function applyPlayerExitCollision(e: UpdateEvent, dir: Point, player: Player, exit: ExitDoor): void {
			var index: int = exits.indexOf(exit);
			if(index == nextLevelIndex) {
				isDead = true;
			}
		}
	}

}
