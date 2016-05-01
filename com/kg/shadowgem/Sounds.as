package com.kg.shadowgem {

	import flash.display.MovieClip;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;

	/**
	 * Defines a class that manages the sound state for the game.
	 */
	public class Sounds {

		/**
		 * Whether the sounds have been loaded into the game.
		 */
		private static var isInitialized: Boolean = false;

		/**
		 * The name of the load level sound.
		 */
		private static const LOAD_LEVEL: String = "LOAD_LEVEL";

		/**
		 * The name of the jump sound.
		 */
		private static const JUMP: String = "JUMP";

		/**
		 * The name of the lose sound.
		 */
		private static const LOSE: String = "LOSE";

		/**
		 * The name of the mouse monster moving sound.
		 */
		private static const MOUSE_MONSTER_MOVE: String = "MOUSE_MONSTER_MOVE";

		/**
		 * The name of the mouse monster moving sound.
		 */
		private static const MOUSE_MONSTER_HURT: String = "MOUSE_MONSTER_HURT";

		/**
		 * The name of the pickup ammo sound.
		 */
		private static const PICKUP_AMMO: String = "PICKUP_AMMO";

		/**
		 * The name of the pickup gem sound.
		 */
		private static const PICKUP_GEM: String = "PICKUP_GEM";

		/**
		 * The name of the player shooting sound.
		 */
		private static const SHOOT: String = "SHOOT";

		/**
		 * The name of the player hurt sound.
		 */
		private static const HURT: String = "HURT";

		/**
		 * The name of the turret shooting sound.
		 */
		private static const TURRET_SHOOT: String = "TURRET_SHOOT";

		public function Sounds() {
		}

		/**
		 * Plays the load level sound.
		 */
		public static function loadLevel(): void {
			checkInitialized();
			SoundAS.play(LOAD_LEVEL);
		}

		/**
		 * Plays the jump sound.
		 */
		public static function jump(): void {
			checkInitialized();
			SoundAS.playFx(JUMP);
		}

		/**
		 * Plays the lose sound.
		 */
		public static function lose(): void {
			checkInitialized();
			SoundAS.play(LOSE);
		}

		/**
		 * Plays the player hurt sound.
		 */
		public static function hurt(): void {
			checkInitialized();
			SoundAS.playFx(HURT);
		}

		/**
		 * Plays the mouse monster moving sound.
		 * @return SoundInstance The sound that represents the sound for the mouse movement. Stop this sound when the mouse dies.
		 */
		public static function mouseMonsterMove(): SoundInstance {
			checkInitialized();
			return SoundAS.play(MOUSE_MONSTER_MOVE, 0.1, 0, int.MAX_VALUE, true, true, true);
		}

		/**
		 * Plays the mouse monster hurt sound.
		 */
		public static function mouseMonsterHurt(): void {
			checkInitialized();
		  SoundAS.playFx(MOUSE_MONSTER_HURT);
		}

		/**
		 * Plays the pickup ammo sound.
		 */
		public static function pickupAmmo(): void {
			checkInitialized();
			SoundAS.playFx(PICKUP_AMMO);
		}

		/**
		 * Plays the pickup gem sound.
		 */
		public static function pickupGem(): void {
			checkInitialized();
			SoundAS.playFx(PICKUP_GEM);
		}

		/**
		 * Plays the player shooting sound.
		 */
		public static function shoot(): void {
			checkInitialized();
			SoundAS.playFx(SHOOT);
		}

		/**
		 * Plays the pickup turret shooting sound.
		 */
		public static function turretShoot(): void {
			checkInitialized();
			SoundAS.playFx(TURRET_SHOOT);
		}

		/**
		 * Checks whether the sounds have been initialized, and initializes(loads) them if not.
		 *
		 */
		private static function checkInitialized(): void {
			if(!isInitialized) {
				SoundAS.loadSound("audio/LoadLevel.mp3", LOAD_LEVEL);
				SoundAS.loadSound("audio/Jump.mp3", JUMP);
				SoundAS.loadSound("audio/Lose.mp3", LOSE);
				SoundAS.loadSound("audio/MouseMonsterMove.mp3", MOUSE_MONSTER_MOVE);
				SoundAS.loadSound("audio/PickupAmmo.mp3", PICKUP_AMMO);
				SoundAS.loadSound("audio/PickupGem.mp3", PICKUP_GEM);
				SoundAS.loadSound("audio/Shoot.mp3", SHOOT);
				SoundAS.loadSound("audio/TurretShoot.mp3", TURRET_SHOOT);
				SoundAS.loadSound("audio/MouseMonsterHurt.mp3", MOUSE_MONSTER_HURT);
				SoundAS.loadSound("audio/Hurt.mp3", HURT);
				isInitialized = true;
			}
		}

	}

}
