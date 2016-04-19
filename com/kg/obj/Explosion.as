package com.kg.obj {

	import flash.display.MovieClip;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a dynamic explosion of objects.
	 * These objects behave very similarly to emitters, the only difference is that
	 * these objects only emit objects once, and they emit several objects at once.
	 */
	public class Explosion extends ObjectEmitter {

    /**
		 * The number of objects that should be created.
		 */
		public var objectCount: int = 10;

		/**
		 * Creates a new Explosion.
		 */
		public function Explosion() {
		}

		/**
		 * Configures this explosion. Should be called after the explosion is added to the view tree.
		 */
		public override function setup(): void {
			super.setup();
			for(var i: int = 0; i < objectCount; i++) {
				addObject(createObject());
			}
		}

		/**
		 * Creates a new ExplosionDot that takes part in the explosion.
		 * @return BoundedObject
		 */
		protected override function createObject(): BoundedObject {
			return new ExplosionObject();
		}

		/**
		 * Updates this explosion, effectively animating it.
		 * @param e:UpdateEvent The current frame update event.
		 */
		public override function update(e: UpdateEvent): void {
			updateObjects(e);
			isDead = objects.length == 0;
		}
	}

}
