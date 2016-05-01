package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.Button;
	import com.kg.state.UpdateEvent;
  import flash.display.DisplayObject;
	import treefortress.sound.SoundInstance;

	/**
	 * Defines a class that represents a button that animates a gem when hovered.
	 */
	public class GemButton extends Button {

		/**
		 * The timer that represents where the button is in it's animation.
		 */
		protected var counter: Number = 0;

		/**
		 * Whether the mouse was hovering over the button during the last frame.
		 */
		private var wasHovering: Boolean = false;

		public function GemButton() {
		}

		public override function update(e: UpdateEvent): void {
			super.update(e);
      var first = getNormalGem();
      var second = getHoveredGem();
			if(hovering) {
				first.alpha = 0;
				second.alpha = 1;
        animate(second);
        first.y = second.y;
				first.x = second.x;
				counter += e.deltaTime;
				if(!wasHovering) {
					Sounds.pickupGem();
				}
			} else {
				first.alpha = 1;
				second.alpha = 0;
			}
			wasHovering = hovering;
		}

    /**
     * Animates the given object.
     * @param first:DisplayObject The object that should be animated.
     */
    protected function animate(obj: DisplayObject): void {
      obj.y = 25 + Math.sin(counter * 3) * 5;
    }

    /**
     * Gets the gem that is displayed when the button is not hovered.
     * @return DisplayObject The gem that should be displayed when this button is in its normal state.
     */
    protected function getNormalGem(): DisplayObject {
      return null;
    }

    /**
     * Gets the gem that is displayed when the button is hovered.
     * @return DisplayObject The gem that should be displayed when this button is in its hovered state.
     */
    protected function getHoveredGem(): DisplayObject {
      return null;
    }

		public override function dispose(): void {
			super.dispose();
		}
	}

}
