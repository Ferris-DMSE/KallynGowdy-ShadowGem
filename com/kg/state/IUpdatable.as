package com.kg.state {
	import com.kg.state.UpdateEvent;

	/**
	 * Defines an interface for objects that need an update event loop.
	 */
	public interface IUpdatable {
		/**
		 * Triggers the update event for a frame on the object.
		 * @param updateEvent:UpdateEvent The current frame update event object.
		 */
		function update(updateEvent:UpdateEvent): void;
	}

}
