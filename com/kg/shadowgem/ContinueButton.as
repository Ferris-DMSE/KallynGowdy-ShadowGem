﻿package com.kg.shadowgem {

	import flash.display.MovieClip;
	import com.kg.obj.Button;
	import com.kg.state.UpdateEvent;
	import flash.display.DisplayObject;
	

	/**
	 * Defines a class that represents the continue button.
	 */
	public class ContinueButton extends GemButton {

		public function ContinueButton() {
		}

		protected override function getNormalGem(): DisplayObject {
			return green;
		}

		protected override function getHoveredGem(): DisplayObject {
			return shadow;
		}

	}

}
