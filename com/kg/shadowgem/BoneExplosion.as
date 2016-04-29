package com.kg.shadowgem {

	import flash.display.MovieClip;
  import com.kg.obj.Explosion;
  import com.kg.obj.BoundedObject;

	/**
	 * Defines a class that represents an explosion of bones.
	 */
	public class BoneExplosion extends Explosion {

		public function BoneExplosion() {
      super();
      objectCount = 5;
		}

    protected override function createObject(): BoundedObject {
			return new MonsterDeathBone();
		}
	}

}
