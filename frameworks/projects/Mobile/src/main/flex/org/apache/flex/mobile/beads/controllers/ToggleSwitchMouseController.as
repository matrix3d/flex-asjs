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
package org.apache.flex.mobile.beads.controllers
{
	import org.apache.flex.core.IBeadController;
	import org.apache.flex.core.IToggleButtonModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.events.MouseEvent;
	import org.apache.flex.mobile.beads.ToggleSwitchView;
    COMPILE::JS
    {
        import goog.events;
        import goog.events.EventType;
    }
	
	/**
	 *  The ToggleSwitchMouseController bead handles mouse events on the 
	 *  ToggleSwitch, allowing the user to use the mouse to change the
	 *  state of the ToggleSwitch.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class ToggleSwitchMouseController implements IBeadController
	{
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function ToggleSwitchMouseController()
		{
		}
		
		private var model:IToggleButtonModel;
		
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @flexjsignorecoercion org.apache.flex.html.Spinner
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			model = UIBase(value).model as IToggleButtonModel;
			
            COMPILE::AS3
            {
                var viewBead:ToggleSwitchView = value.getBeadByType(IBeadView) as ToggleSwitchView;
                viewBead.boundingBox.addEventListener(MouseEvent.CLICK, asClickHandler);
				viewBead.actualSwitch.addEventListener(MouseEvent.CLICK, asClickHandler);
            }
            
            COMPILE::JS
            {
				var viewBead:ToggleSwitchView = value.getBeadByType(IBeadView) as ToggleSwitchView;
				
				goog.events.listen(viewBead.boundingBox.element, goog.events.EventType.CLICK,
					jsClickHandler);
				goog.events.listen(viewBead.actualSwitch.element, goog.events.EventType.CLICK,
					jsClickHandler);

            }
		}
		
		/**
		 * @private
		 */
		COMPILE::AS3
		private function asClickHandler( event:MouseEvent ) : void
		{
			var oldValue:Boolean = model.selected;
			model.selected = !oldValue;
			IEventDispatcher(_strand).dispatchEvent(new Event("valueChanged"));
		}
        
		/**
		 * @private
		 */
		COMPILE::JS
		private function jsClickHandler( event:Event ) : void
		{
			var oldValue:Boolean = model.selected;
			model.selected = !oldValue;
			IEventDispatcher(_strand).dispatchEvent(new Event("valueChanged"));
		}
	}
}
