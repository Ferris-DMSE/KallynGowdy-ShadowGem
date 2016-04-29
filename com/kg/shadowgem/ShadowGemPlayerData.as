package com.kg.shadowgem {

  import com.kg.obj.PlayerData;
  import com.kg.obj.MovingObject;

	/**
	 * Defines a class that is used to store the current player's state. (score, lives, level, etc.)
	 */
	public class ShadowGemPlayerData extends PlayerData {

    /**
     * The amount of ammo that the player has left.
     */
    public var ammo: int = 0;

		/**
		 * Creates a new PlayerData object that can be used to store a player's state in the game.
		 */
		public function ShadowGemPlayerData(player: MovingObject) {
			super(player);
		}

	}

}
