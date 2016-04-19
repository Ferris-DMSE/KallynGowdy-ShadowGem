package com.kg.obj {
	/**
	 * Defines a utility class that contains functions that do not belong to a specific object class.
	 */
	public class Utils {

		/**
		 * Creates a new instance of the utils class.
		 * I don't know why you would ever want to do this, considering that every method is static in the Utils class.
		 * I can probably make this class static, I just haven't looked into it yet.
		 */
		public function Utils() {
		}

		/**
		 * Incrementally moves the given current value towards the target value at the rate defined by the given step and returns the updated value.
		 * @param currentValue:Number The value that should be "moved" toward the target value.
		 * @param targetValue:Number The value that the current value should be moved towards.
		 * @param step:Number The rate at which the current value should move towards the target value.
		 */
		public static function animateNumberTowards(currentValue: Number, targetValue: Number, step: Number): Number {
			var newValue = currentValue;
			var dist = Math.abs(targetValue - currentValue);
			if(dist < step) {
				newValue = targetValue;
			} else {
				if(newValue < targetValue) {
					newValue += step;
				} else if(newValue > targetValue) {
					newValue -= step;
				}
			}
			return newValue;
		}

		/**
		 * "Generates" a random number between the given minimum and maximum values.
		 * @param min:Number The minimum value that the random number should take on.
		 * @param max:Number The maximim value that the random number should take on.
		 */
		public static function randomBetween(min: Number, max: Number): Number {
			return min + Math.random() * (max - min);
		}

	}

}
