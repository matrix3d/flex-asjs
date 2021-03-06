////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.events
{
    COMPILE::AS3 {
        import flash.events.Event;
    }
        
	COMPILE::JS {
		import goog.events.Event;
	}

	/**
	 * This class simply wraps flash.events.Event so that
	 * no flash packages are needed on the JS side.
	 * At runtime, this class is not always the event object
	 * that is dispatched.  In most cases we are dispatching
	 * DOMEvents instead, so as long as you don't actually
	 * check the typeof(event) it will work
	 *
	 * @langversion 3.0
	 * @playerversion Flash 10.2
	 * @playerversion AIR 2.6
	 * @productversion FlexJS 0.0
	 */
	COMPILE::AS3
	public class Event extends flash.events.Event
	{

		//--------------------------------------
		//   Static Property
		//--------------------------------------

		static public const CHANGE:String = "change";

		//--------------------------------------
		//   Constructor
		//--------------------------------------

		/**
		 * Constructor.
		 *
		 * @param type The name of the event.
		 * @param bubbles Whether the event bubbles.
		 * @param cancelable Whether the event can be canceled.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10.2
		 * @playerversion AIR 2.6
		 * @productversion FlexJS 0.0
		 */
		public function Event(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		//--------------------------------------
		//   Property
		//--------------------------------------

		//--------------------------------------
		//   Function
		//--------------------------------------

		/**
		 * @private
		 */
		public override function clone():flash.events.Event
		{
			return cloneEvent();
		}

		/**
		 * Create a copy/clone of the Event object.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 10.2
		 * @playerversion AIR 2.6
		 * @productversion FlexJS 0.0
		 */
		public function cloneEvent():org.apache.flex.events.Event
		{
			return new org.apache.flex.events.Event(type, bubbles, cancelable);
		}
	}

    COMPILE::JS
    public class Event extends goog.events.Event {

		public static const CHANGE:String = "change";

        public function Event(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type);
			this.bubbles = true;
			this.cancelable = true;
        }

		public var bubbles:Boolean;
		public var cancelable:Boolean;
				
		/**
		 * Google Closure doesn't seem to support stopImmediatePropagation, but
		 * actually the HTMLElementWrapper fireListener override sends a
		 * BrowserEvent in most/all cases where folks need stopImmediatePropagation
		 * so we put this in here for compile time since it will exist in
		 * the BrowserEvent that does get sent around.
		 */
		public function stopImmediatePropagation():void
		{
			throw new Error("stopImmediatePropagation");
		}
		
		public function cloneEvent():org.apache.flex.events.Event
		{
			return new org.apache.flex.events.Event(type, bubbles, cancelable);
		}
    }
}
