﻿package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.RectangularObject;
	import flash.geom.Point;
	import com.kg.state.UpdateEvent;

	/**
	 * Defines a class that represents a floor.
	 * This floor is not actually metal, but I named it before I made the art, so I never renamed it.
	 */
	public class MetalFloor extends RectangularObject {

		public function MetalFloor() {
			super();
		}

		public override function setup(): void {
			super.setup();
			boundless();
		}

		protected override function findColliderPosition(): Point {
			return new Point(x - width / 2, y - height / 2);
		}

		protected override function findNewVelocity(e: UpdateEvent): Point {
			return new Point(0, 0);
		}
	}

}
